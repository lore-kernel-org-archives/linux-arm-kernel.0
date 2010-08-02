From: nitvishnoi@gmail.com (nitin vishnoi)
Date: Mon, 2 Aug 2010 11:42:07 +0530
Subject: not coming prompt in 2.6.33.6 kernel
In-Reply-To: <AANLkTim8KEn7-dFpHdbYs0Wvi_hxjrbmUmhEQ2nMOtHj@mail.gmail.com>
References: <AANLkTikgB9OF6mRqZ2KgQYuCQ4JcF7N6oTJyUbrYq0t7@mail.gmail.com>
	<20100728094344.GA9142@trinity.fluff.org>
	<AANLkTikgq_Fb0ZfT-b+9zOA5w2pDpNgwnUqe919hAsnd@mail.gmail.com>
	<AANLkTin8STiQqvjZo-atA9jhz1OLWuk2k61-VYnZrcD8@mail.gmail.com>
	<AANLkTim8KEn7-dFpHdbYs0Wvi_hxjrbmUmhEQ2nMOtHj@mail.gmail.com>
Message-ID: <AANLkTikZwzfY4kJ-9i5Y87vA7HMutRJUM5-5Y_HnQeb=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
Finally i got the prompt,
the problem was in toolchain.I compiled the busybox and kernel with other
new toolchain and made the ramdisk filesystem.Than i got the prompt.

Regards

Nitin

On Fri, Jul 30, 2010 at 8:55 PM, Martin Fuzzey <mfuzzey@gmail.com> wrote:

> Hi,
> On Fri, Jul 30, 2010 at 12:40 PM, nitin vishnoi <nitvishnoi@gmail.com>
> wrote:
> > Hi now i am able the uart info also.Bu stil not getting the prompt.
> > and getting the following log.
> >
> > Starting kernel ...
> >
> >
> > Uncompressing
> >
> Linux......................................................................
> > done, booting the kernel.
> > Linux version 2.6.31.14 (root at ubntu-desktop) (gcc version 4.1.2) #34 Fri
> Jul
> > 30 15:33:38 IST 2010
> > CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
> > CPU: VIVT data cache, VIVT instruction cache
> > Kernel command line: root=/dev/ram initrd=0x30800000,8M ramdisk=24576
> > init=/sbin/init console=ttySAC3,115200 mem=64M
> > RAMDISK: gzip image found at block 0
> > EXT2-fs warning: maximal mount count reached, running e2fsck is
> recommended
> > VFS: Mounted root (ext2 filesystem) on device 1:0.
> > Freeing init memory: 88K
> > Kernel panic - not syncing: Attempted to kill init!
> >
>
> Looks like the init process is terminating unexpectedly.
> What's /sbin/init for you?
> How is it compiled? (could it be a OABI / EABI issue?)
>
> What happens if you try booting with  init=/bin/sh   ?
> or try using a script like this as init
>
> #! /bin/sh
> echo "Test stdout"
> echo "Test console" > /dev/console
> echo "Test tty1" > /dev/tty1
> /bin/ls -l /dev > /dev/tty1
>
> Cheers,
> Martin
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100802/7342104e/attachment.html>
