From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 19 May 2010 03:24:08 +0100
Subject: your mail
In-Reply-To: <1274179129-14659-1-git-send-email-m.szyprowski@samsung.com>
References: <1274179129-14659-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20100519022408.GN26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 12:38:38PM +0200, Marek Szyprowski wrote:
> Hello,

Hi, messages are supposed to have subjects... please supply one next
timne.
 
> This patch series perform a general cleanup in Samsung S5PC100 SoC support.
> This chip is moved from custom s5pc1xx platform framework to new plat-s5p
> framework, so more common code can be easily reused in upcomming extensions
> for S5PV210/S5PC110 SoCs.
> 
> This patch series is prepared against next-samsung tree, with assumption
> that the "[PATCH v3] ARM: S5PC100: Pre-requisite clock patch for
> plat-s5pc1xx to plat-s5p" has been applied as well as the '[PATCH v6]
> ARM: S5PV210: Add Ext interrupt support' (with additional bug fixes).
>
> I've tried to split my changes as much as possible to clearly show how the
> transition from plat-s5pc1xx to plat-s5p is being done.

Ok, this seems to be a pretty good progression from one to the other.

I will chase up the EINT support, it got dropped from the first pull due
to your bug reports.

Will start sorting out a second round of branches with a view to trying to
get this into the current merge window. I hope to have something to test
by the end of today.
 
> Changes since v2:
> - fixed some whitespace/tabs errors
> - removed external interrupt code, a common code from plat-s5p will be used
> - moved SMDKC100 fixes to separate patch series
> 
> Changes since v1:
> - bases on completely new clock code provided by Kukjin Kim
> - added some plat-s5p fixes required for transition
> - removed custom functions from gpiolib implementation (now uses common
>   code from plat-samsung)
> - restructured the changes to avoid breaking the functionality beteen the
>   patches
> - some other minor cleanups (mainly c1xx to c100 renames)
> 
> This patch series includes:
> 
> [PATCH 01/11] drivers: serial: S5PC100 serial driver cleanup
> [PATCH 02/11] ARM: S5PC100: Use common functions for gpiolib implementation
> [PATCH 03/11] ARM: S5PC100: Move gpio support from plat-s5pc1xx to mach-s5pc100
> [PATCH 04/11] ARM: S5PC100: gpio.h cleanup
> [PATCH 05/11] ARM: S5PC100: Move frame buffer helpers from plat-s5pc1xx to mach-s5pc100
> [PATCH 06/11] ARM: S5PC100: Move i2c helpers from plat-s5pc1xx to mach-s5pc100
> [PATCH 07/11] ARM: S5PC100: Move sdhci helpers from plat-s5pc1xx to mach-s5pc100
> [PATCH 08/11] ARM: Samsung: move S5PC100 support from plat-s5pc1xx to plat-s5p framework
> [PATCH 09/11] ARM: S5PC100: Add support for gpio interrupt
> [PATCH 10/11] ARM: S5PC100: use common plat-s5p external interrupt code
> [PATCH 11/11] ARM: remove obsolete plat-s5pc1xx directory
> 
> Best regards
> --
> Marek Szyprowski
> Samsung Poland R&D Center
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
