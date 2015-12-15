From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Dec 2015 12:30:57 +0100
Subject: MP11 port
In-Reply-To: <CACRpkdYfQg1tFemWCK-CbWh2LyZpQG9Keh2xvLRwOQvX8SONcg@mail.gmail.com>
References: <CAMou_+dOdmxfsB9Xx1Kbci_uSoPpy-dBf9Ct7Ku+sJ1gE=r0mA@mail.gmail.com>
 <CACRpkdYfQg1tFemWCK-CbWh2LyZpQG9Keh2xvLRwOQvX8SONcg@mail.gmail.com>
Message-ID: <15449033.rcuzkgqmSU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 December 2015 10:19:57 Linus Walleij wrote:

> On Sun, Nov 24, 2013 at 7:36 PM, Ferrari Dante L?szl?
> <dante.ferrari@gmail.com> wrote:
> 
> > I am quite new to the ARM world, and hope that you will have the
> > patience to help me out with my question. I would like to start a
> > basic kernel on an MP11 platform with only 6MB of RAM.

So what hardware is this really? The original Realview had much more
RAM than this, so I assume this is a custom design of some sort?

> Jesus Christ. Well you may be able to start the kernel, but I'm
> suspcious about how much userspace you will have with that.
> But I guess you can get a busybox prompt with a rootfs on
> flash or SD card or so.

It really depends: the smallest I've heard of was a rather patched-up
kernel running on 256KB of RAM using all the tricks known to mankind
(XIP_KERNEL, XIP fs, no MMU, ...)

Some folks are running NOMMU kernels built from usptream sources on
machines as small as 2MB, which is probably the limit to what you
can do without out-of-tree hacks. 6MB is tight, but possible.

We recently found that going to DT support requires an additional
80kb of uncompressed kernel size in flash, but I'm not sure about
the runtime cost. For a multiplatform kernel, using DT tends to be
a win, as we can leave out the board files, but for a tiny kernel
on a single machine, I'm sure there is some overhead.

> >I have a problem when the
> > GIC is switched on, from __log_buf I can get some info about the state
> > of the booting procedure.
> >
> > Booting Linux on physical CPU 0x0
> > Linux version 3.12.0-01915-g6c86ae2-dirty (dante at dante-Latitude-D620)
> 
> The kernel developers use Torvald's HEAD for all development.
> In this case I'd recommend you to check if maybe you want
> to use my patch stack as base and boot from DT for the moment.

+1

	Arnd
