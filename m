From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Mar 2012 13:52:59 +0000
Subject: [alsa-devel] [PATCH 15/20] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
In-Reply-To: <20120306133818.GV19635@opensource.wolfsonmicro.com>
References: <4F53FBA1.8090200@freescale.com>
 <20120305000411.GL7363@n2100.arm.linux.org.uk>
 <4F54053F.9070502@freescale.com>
 <20120305002635.GA23798@opensource.wolfsonmicro.com>
 <20120306104015.GF17370@n2100.arm.linux.org.uk>
 <20120306120646.GH19635@opensource.wolfsonmicro.com>
 <20120306122516.GH17370@n2100.arm.linux.org.uk>
 <20120306123322.GP19635@opensource.wolfsonmicro.com>
 <s5h4nu17tdn.wl%tiwai@suse.de>
 <20120306133818.GV19635@opensource.wolfsonmicro.com>
Message-ID: <20120306135259.GJ17370@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2012 at 01:38:18PM +0000, Mark Brown wrote:
> On Tue, Mar 06, 2012 at 02:26:28PM +0100, Takashi Iwai wrote:
> > Mark Brown wrote:
> > > On Tue, Mar 06, 2012 at 12:25:16PM +0000, Russell King - ARM Linux wrote:
> 
> > > whenever you need to call back into the ALSA APIs.  Though of course I'm
> > > pretty sure there's a bunch of uniprocessor assumptions through the body
> > > of driver code anyway...
> 
> > Not that much actually.  On the contrary, because of the current
> > design allowing concurrent accesses, many codes have been written
> > rather in too complex and messy ways.  It could have been much
> > simplified if we didn't consider the concurrent accesses to each
> > substream.
> 
> Right, but I'm fairly sure that at least some of the driver code is
> relying on uniprocessor assumptions for what it's doing

Mark,

Stop using the term "uniprocessor assmptions".

Thinking that something is safe because you're running on a uniprocessor
system is total bollocks at every level.

You can get other threads scheduled on a uniprocessor system because you
happen to have called a function which has slept beneath you.  As you
later mention in your reply, preempt.  Preempt will effectively turn a
UP system into an effective SMP system as far as proper locking goes.

So, to talk about "uniprocessor assumptions" is at best misleading, but
is totally and utterly wrong.  Please stop mudding the issue with your
system programming misunderstandings.

What you mean is "single threaded assumptions".  Please use this term
instead - it's what you actually mean.
