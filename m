From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 Aug 2013 09:12:03 -0700
Subject: linux-next: manual merge of the arm-soc tree with the usb tree
In-Reply-To: <521CC4E3.8030204@linutronix.de>
References: <20130827181353.319c150858829df1bb68d60b@canb.auug.org.au>
 <521C6961.9020103@linutronix.de>
 <CABxcv=mg6t5wPqpF3j5sr_76qfZ7N7KgpWhcKSGoPTOcaR=V6A@mail.gmail.com>
 <521CA888.1080909@baylibre.com> <521CAF59.1090203@linutronix.de>
 <521CB046.9070408@baylibre.com> <878uznxjnl.fsf@linaro.org>
 <521CC4E3.8030204@linutronix.de>
Message-ID: <20130827161203.GA22852@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 05:25:23PM +0200, Sebastian Andrzej Siewior wrote:
> On 08/27/2013 05:01 PM, Kevin Hilman wrote:
> >>> What do we do now?
> >>
> >> Cannot you just merge the stable arm-soc/dt branch into your branch
> >> before applying your patches?
> > 
> > Unfortunately, the next/dt branch of arm-soc is not necessarily stable
> > so should *not* be merged.  In fact none of the arm-soc branches should
> > be considered stable.
> > 
> > As was already mentioned, this should be split up into driver changes
> > and DTS changes through arm-soc.  They'll both merge for v3.12.
> 
> But splitting will break the driver until .dts & code is in sync again.
> 
> > BTW, how did this patch get merged without a signoff/ack from the OMAP
> > DT maintainer in the first place?  Hmm, looks like Benoit was not copied
> > nor was linux-omap or linux-arm-kernel copied in the original mails.
> 
> Hmm. I had Benoit's okay [0] to do the change "as long as Felipe is
> fine with it". I indeed forgot to Cc Benoit on the dts changes.
> For the phy-rename Felipe pinged you and we did the topic-branch, here
> I forgot.

No. Read that email again. What Benoit said was that if Felipe was fine
with the change _HE_ would take it. Huge difference, and one that would have
avoided this situation.

The only way to solve these things in the future is to make the driver handle
both the new and the old binding. Bindings are not supposed to change in
incompatible ways any more, unless for special circumstances and/or when the
old binding was completely broken.


The only way forward here, since Greg runs a stable tree that he doesn't
rebase, is for us to rebuild without the OMAP DT branch, and ask Benoit to take
out the conflicting changes.

Benoit, I know this is none of your fault, but would you mind preparing a new
copy of the DT branch without the conflicting patches, and hold those to 3.13?
I haven't looked to see how many those were.


-Olof
