From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 24 Sep 2016 10:15:15 +0100
Subject: UBSAN: Undefined behaviour in ./arch/arm/include/asm/bitops.h
In-Reply-To: <57E604ED.6000408@samsung.com>
References: <CGME20160922045043epcas1p2e275276a65b244a5a013842597fcc0f1@epcas1p2.samsung.com>
 <1474519757-10228-1-git-send-email-sw0312.kim@samsung.com>
 <57E604ED.6000408@samsung.com>
Message-ID: <20160924091515.GD1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 24, 2016 at 01:45:33PM +0900, Seung-Woo Kim wrote:
> With the patch "arm: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL", I got
> following UBSAN warning on Exynos5422 SoC board.

Well, the simple solution is to have fls() and ffs() take unsigned int
arguments rather than ints - but the question that brings up is: why
do both of these take signed ints?  It seems at least to me that it
would be more sensible for these to take unsigned int, or even
unsigned long like the other bitops do.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
