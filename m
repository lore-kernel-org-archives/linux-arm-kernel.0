From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 4 Jun 2013 10:13:35 +0200
Subject: [PATCH] ARM: atags: add support for Marvell's u-boot
In-Reply-To: <20130603191730.GR3803@titan.lakedaemon.net>
References: <1370277937-2965-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130603171017.GN18614@n2100.arm.linux.org.uk>
 <20130603175629.GH5008@1wt.eu>
 <20130603181437.GO3803@titan.lakedaemon.net>
 <20130603183057.GA9868@1wt.eu>
 <20130603184148.GQ3803@titan.lakedaemon.net>
 <alpine.LFD.2.03.1306031502450.1200@syhkavp.arg>
 <20130603191730.GR3803@titan.lakedaemon.net>
Message-ID: <20130604101335.6be6ed3b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Mon, 3 Jun 2013 15:17:31 -0400, Jason Cooper wrote:

> > Isn't upstream U-Boot supporting Marvell devices properly these days?  
> > If so maybe considering a U-Boot upgrade would be the best way forward?
> 
> Yes, both u-boot and barebox are supporting Marvell devices,

Sorry Jason, but you're overstating the status of this support:

 * Barebox has only *minimal* support for Marvell SoCs, i.e only the
   serial console and timers are supported. There is no support for
   network, NAND, SPI or anything that even allows to load a kernel and
   boot it.

 * U-Boot has zero support for Armada 370 and Armada XP, and Sebastian
   has tried for several months to push support for Marvell Dove,
   without success (lack of review/interest from the U-Boot
   maintainers, if I remember correctly).

So as of today, the Marvell-specific U-Boot is the /only/ working
solution for Armada 370 and Armada XP based platforms, and it will
remain this way at least for several months, until we've pushed enough
work into Barebox. And even at that time, as you say, users may not
necessarily be willing to upgrade their bootloader.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
