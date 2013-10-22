From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 22 Oct 2013 11:39:24 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
Message-ID: <20131022093923.GC15640@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 04:40:15PM -0400, Nicolas Pitre wrote:
> On Mon, 21 Oct 2013, Stephen Warren wrote:
[...]
> > but taking the big picture into
> > account, observe that we make life a lot more difficult for distros,
> > since they need to get the device tree from somewhere. Distros now are
> > forced to work out which DTB goes with which board,
> 
> This is not a new problem.  Before you had to figure out which kernel 
> would go with which board.

You still need to match kernels to boards even with DT. It's no good if
you provide a full DTB that describes your hardware if the kernel
doesn't support any of it.

> > or perhaps we need
> > to define a firmware interface to obtain the DTB and pass it to the
> > kernel.
> 
> That's the bootloader's job.  Nothing magical actually: just have U-Boot 
> or whatever load the DTB from some flash area.

I agree. I think most if not all architectures that support DT have long
had some interface on how to pass a DTB to the kernel. At least I know
that ARM and x86 have, but I'm pretty sure that PowerPC, SPARC and
others do too.

> > I
> > think we can still have a hack-free, churn-free, multi-platform kernel
> > without requiring DT, but by using board files.
> 
> I kinda agree with you, but this is too late for that now.
> 
> We have DT, and the best way forward is to fix the process which is, 
> arguably, somewhat obstructive and broken at the moment.

I agree that the process could use some enhancements. But I also think
that we should be open to move away from DT again if it turns out to not
be a good enough solution. "It's too late" doesn't sound like a very
good argument to me.

Essentially DT is just a different way to represent what we used to have
in platform data, so we haven't fundamentally changed anything at that
level. Well, we've made things worse to some degree.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131022/de1ef011/attachment.sig>
