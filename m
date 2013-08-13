From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Aug 2013 12:30:04 +0100
Subject: [Qemu-devel] SCSI bus failures with qemu-arm in kernel 3.8+
In-Reply-To: <1376383051.2737.20@driftwood>
References: <20130812164548.GE23006@n2100.arm.linux.org.uk>
 <1376383051.2737.20@driftwood>
Message-ID: <20130813113004.GJ23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 03:37:31AM -0500, Rob Landley wrote:
> Because working with old and new qemu, like it used to before everybody  
> fiddled with it to not actually match hardware nobody _has_, is  
> definitely not an interesting goal.

It appears that people *do* have the hardware.

What is also "not interesting" is to have bugs reported, I state that I
won't fix it unless we know what the hardware is supposed to be, and
then for everything to go quiet, and qemu to have patches put in to
"work around" the problem.

Software emulators are exactly that: they are software.  They contain
bugs, just like any other bit of software.  With the lack of clear
documentation about the hardware, and comments in the code written by
ARM Ltd when this stuff was first created, the only thing which can
be taken as definitive is the comments, which is exactly what I did.

Then to have people using qemu report that something is broken - sorry,
but software emulation doesn't matter in that regard.  Especially when
we've had reports that "the kernel is broken" wrt timers and it turns
out to be a bug in qemu not emulating them correctly.  Think about it -
how do we know whether the kernel is buggy or the software emulation is
buggy.  Without going back to the hardware or pointing at documentation,
we can't answer that question.  So it's safer to leave things as-is.

It seems that the documentation over the years from ARM Ltd has improved
to the point that it is now possible to figure out some of the details,
if you're prepared to spend a lot of time finding it in the latest
documentation and tracing circuit diagrams.  (ARMs documentation site is
pretty horrid to find documents on.)

Well, that has now finally happened, so we can be finally be confident
what the correct answer is to this.  This is all something which should
have happened yonks ago.
