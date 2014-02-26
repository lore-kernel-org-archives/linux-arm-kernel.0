From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Feb 2014 15:02:50 +0100
Subject: [PATCH] scripts/link-vmlinux.sh: correct base address for some
 ARM special cases
In-Reply-To: <20140226135352.GY21483@n2100.arm.linux.org.uk>
References: <1393413080-26942-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140226134605.GF6865@pengutronix.de>
 <20140226135352.GY21483@n2100.arm.linux.org.uk>
Message-ID: <24560058.bYFu9ts53f@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 February 2014 13:53:52 Russell King - ARM Linux wrote:
> It's more to the point.  The first hunk hides the "Memory split" option
> which is irrelevent on !MMU.  We already know that PAGE_OFFSET should
> be the same as PHYS_OFFSET for noMMU, so let's make that explicit.
> Note that it already is by way of the bit in the last hunk - which as
> a result of this change can now be removed... especially so as we have
> nothing defining PAGE_OFFSET in arch/arm/*/include...

Looks good to me as well. I first wasn't sure about what this would do
for platforms that define their own PLAT_PHYS_OFFSET, but we they are
broken anyway if you set a DRAM_BASE that is not the same as
PLAT_PHYS_OFFSET.

	Arnd
