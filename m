From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Feb 2014 15:16:40 +0100
Subject: [PATCH] scripts/link-vmlinux.sh: correct base address for some
 ARM special cases
In-Reply-To: <20140226140632.GG6865@pengutronix.de>
References: <1393413080-26942-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140226135352.GY21483@n2100.arm.linux.org.uk>
 <20140226140632.GG6865@pengutronix.de>
Message-ID: <5208155.7cW2odY371@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 February 2014 15:06:32 Uwe Kleine-K?nig wrote:
> > It's more to the point.  The first hunk hides the "Memory split" option
> > which is irrelevent on !MMU.  We already know that PAGE_OFFSET should
> > be the same as PHYS_OFFSET for noMMU, so let's make that explicit.
> > Note that it already is by way of the bit in the last hunk - which as
> > a result of this change can now be removed... especially so as we have
> > nothing defining PAGE_OFFSET in arch/arm/*/include...
>
> Looks reasonable. Maybe we can also get rid of PLAT_PHYS_OFFSET then.

I think we still need PLAT_PHYS_OFFSET for the configurations that cannot
use ARM_PATCH_PHYS_VIRT, which are:

* Anything using XIP_KERNEL with MMU=y
* mach-realview with the custom __phys_to_virt hack
* ZBOOT_ROM

	Arnd
