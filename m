From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 11 Nov 2009 11:11:37 -0500 (EST)
Subject: kirkwood / openrd: umount problem using mdev (busybox)
In-Reply-To: <200911111555.02938.dk-arm-linux@gmx.de>
References: <200911061559.47922.dk-arm-linux@gmx.de>
	<200911111555.02938.dk-arm-linux@gmx.de>
Message-ID: <alpine.LFD.2.00.0911111056510.16711@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Nov 2009, Dieter Kiermaier wrote:

> Hi again,
> 
> > Hi all,
> > 
> > I've encountered a new problem with regards to busybox mdev while umounting a usb pendrive:
> > I'm using kernel
> > sh-3.2# uname -a
> > Linux DB88FXX81 2.6.32-rc4 #2 PREEMPT Thu Nov 5 13:41:41 CET 2009 armv5tel GNU/Linux
> > sh-3.2#
> > 
> > 
> > Mounting and umounting manually works like a charm without any problems. But if I disconnected a
> > mounted pendrive and wants mdev to umount it on a remove event the umount call hangs until I get a
> > message from my kernel (see below).
> >
> 
> This problem also doesn't exist with marvell stock 2.6.22.18 kernel.
> So I would assume it is no busybox problem.
> It looks like another kernel problem with current mainline kernel?

Maybe you have misconfigured one feature in your build of the mainline 
kernel compared to the 2.6.22 version?

In any case, given that manually mounting/unmounting does work, this 
suggests the issue hardly can be in the USB host driver.  And everything 
else from your kernel backtrace is generic code not specific to Kirkwood 
or even ARM for that matter.

I'd suggest trying with the very latest kernel and repost your findings 
(including kernel backtrace and all) to linux-kernel at vger.kernel.org and 
CC Jens Axboe <axboe@kernel.dk> who is the block layer maintainer.


Nicolas
