From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 9 Dec 2013 01:54:59 +0100
Subject: [PATCH v2 02/11] arm: pxa27x: support ICP DAS LP-8x4x
In-Reply-To: <1386486335.7152.83.camel@host5.omatika.ru>
References: <1385879185-22455-3-git-send-email-ynvich@gmail.com>
 <201312080321.12001.arnd@arndb.de>
 <1386486335.7152.83.camel@host5.omatika.ru>
Message-ID: <201312090154.59534.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 08 December 2013, Sergei Ianovich wrote:
> On Sun, 2013-12-08 at 03:21 +0100, Arnd Bergmann wrote:
> > On Friday 06 December 2013, Sergei Ianovich wrote:
> > You have some rather unusual options in here. I'd suggest you go through
> > the reduced defconfig file and remove all options that look like they
> > are unnecessary for your system.
> > 
> > It's probably based on some distro config that enables lots of modules
> > you don't actually want.
> 
> I tried to future-proof the config, by enabling all partition tables and
> USB disks and modems that could be plugged into the device.
> 
> I'll remove those. However, I would like to retain config options
> related to low latency and small kernel size. Keeping them will
> hopefully allow being notified about changes affecting the system.
> 
> Will this fly?

Yes, of course, keep as many as you need. I was just trying to ensure
that you had put some thought in it, and e.g. the various USB serial
modules and some other things appeared to be fairly random, but I can
see them making sense now.

> > #define LP8X4X_EOI              0x0006
> > #define LP8X4X_INSINT           0x0008
> > ...
> > 
> > and change the users to do e.g.
> > 
> >         readl(LP8X4X_FPGA_VIRT + LP8X4X_INSINT);
> 
> I am trying to boot the system with device tree. If I manage, I'll move
> this code into drivers/irqchip/ as a platform device. Otherwise, I'll
> make this change.

Ok, cool. If you need help with the DT conversion, just ask here or on
IRC (#armlinux or #mvlinux on freenode.net, there might also be a
PXA specific channel I don't know).

	Arnd
