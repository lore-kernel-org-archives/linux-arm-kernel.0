From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 09 Feb 2012 20:44:22 +0900
Subject: [PATCH 1/2] ARM: EXYNOS: add support GPIO for EXYNOS5250
In-Reply-To: <20120202182726.GO15343@ponder.secretlab.ca>
References: <1328025040-4751-1-git-send-email-kgene.kim@samsung.com>
 <1328025040-4751-2-git-send-email-kgene.kim@samsung.com>
 <20120131224043.GD8338@n2100.arm.linux.org.uk>
 <20120202182726.GO15343@ponder.secretlab.ca>
Message-ID: <06ad01cce720$2acadf50$80609df0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely wrote:
> 
> On Tue, Jan 31, 2012 at 10:40:43PM +0000, Russell King - ARM Linux wrote:
> > On Wed, Feb 01, 2012 at 12:50:39AM +0900, Kukjin Kim wrote:
> > > From: Sangsu Park <sangsu4u.park@samsung.com>
> > >
> > > This patch adds follwing.
> > > - IO-map for EXYNOS5250 GPIO support
> > > - EXYNOS5250 GPIO bank size/number definitions
> > > - memory map definition for S5P GPIO4
> > >
> > > Signed-off-by: Sangsu Park <sangsu4u.park@samsung.com>
> > > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> >
> > Do you actually need these static mapping definitions?  The samsung
> > gpiolib initialization is called from a core_initcall(), and at this
> > time ioremap() is fully capable of working.
> 
> Indeed.  Please get rid of the S5P_VA_GPIO* macros and use ioremap to
> set up the registers mappings.  I understand that the existing code
> already does that, but I don't want to see any more added.  Also, it
> is easy to fix by adding the ioremap calls to samsung_gpio_init()
> 
Yes, I agree. Will be updated with ioremap().

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
