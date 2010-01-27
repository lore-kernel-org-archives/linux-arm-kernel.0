From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 27 Jan 2010 11:12:28 +0100
Subject: defining ZRELADDR as PHYS_OFFSET + TEXT_OFFSET
Message-ID: <20100127101228.GA17421@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

currently all platforms need to define zreladdr-y in
arch/arm/mach-$mach/Makefile.boot and PHYS_OFFSET (in
arch/arm/mach-$mach/include/mach/memory.h).

Constraints for these are:

 TEXTADDR = PAGE_OFFSET + TEXT_OFFSET
 __virt_to_phys(virt) = virt - PAGE_OFFSET + PHYS_OFFSET (at least for
	"small" virtual addresses)
 ZRELADDR = __virt_to_phys(TEXTADDR)

(The equallity for __virt_to_phys only holds "normaly" according to
http://lists.arm.linux.org.uk/lurker/message/20010723.185051.94ce743c.en.html.
In practice it holds for addresses of the first bank of RAM which is
enough for the purposes of this mail.)

So we can deduce ZRELADDR = PHYS_OFFSET + TEXT_OFFSET.

Is there something I missed or is it possible to get rid of zreladdr-y
in .../Makefile.boot and define it according to the equation above?

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
