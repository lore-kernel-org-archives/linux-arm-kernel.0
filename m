From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 May 2011 14:01:04 +0100
Subject: [PATCH 1/1] ARM: thumb: Have the machine name indicate
	operation in thumb mode.
In-Reply-To: <BANLkTinS4XR-QrCsmhStROxkJEy1-PwCTA@mail.gmail.com>
References: <20110514100232.GC30539@n2100.arm.linux.org.uk>
	<20110516121657.GA7715@arm.com>
	<alpine.LFD.2.00.1105161008320.14430@xanadu.home>
	<20110516144311.GC7715@arm.com>
	<BANLkTik0LL+dFCo_H-YhF+BUOXyP7MAKzA@mail.gmail.com>
	<alpine.LFD.2.00.1105181803090.14430@xanadu.home>
	<20110518223319.GB21384@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1105181845540.14430@xanadu.home>
	<20110518225749.GF21384@n2100.arm.linux.org.uk>
	<BANLkTinS4XR-QrCsmhStROxkJEy1-PwCTA@mail.gmail.com>
Message-ID: <20110526130104.GA5762@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2011 at 03:08:05PM -0700, Vadim Bendebury (??) wrote:
> On Wed, May 18, 2011 at 3:57 PM, Russell King - ARM Linux <
> linux at arm.linux.org.uk> wrote:
> > In which case I think we'll have to talk to kbuild people to get
> > mkcompile_h modified.  Also maybe asking what other architectures
> > do for this kind of problem may be a good idea - especially before
> > we start abusing and hacking stuff like the hardware name.
> 
> So, what would be an equivalent in other architectures to ask about - it
> seems that the ability to run in Thumb/ARM mode is fairly unique for ARM.

What about 32-bit vs 64-bit x86 ?

> Consulting /boot/config file is not reliable: in my own setup I can netboot
> either thumb or ARM kernel without changing the root file system contents. I
> agree though that changing the hardware name is not the best way to do this
> either.
> 
> I could look into adding 'thumb' to any element of the uname output, or as a
> watered down version - just add a line to dmesg output?

The thing that I worry about is that userspace will start using this
information inappropriately.  Whether the kernel is built as T2 or ARM
is really only a matter for the kernel itself (and people debugging the
kernel), rather than random userspace programs.

Maybe a way forward would be to produce a patch for mkcompile_h, post it
to here, kbuild people and LKML and see what response is forthcoming.
