From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 09 Feb 2012 20:48:02 +0900
Subject: [PATCH 1/2] ARM: EXYNOS: add support GPIO for EXYNOS5250
In-Reply-To: <CAH9JG2W3Uk=J6GR4C6O6w-vkrG+b=j3ow5mEFbC21EFKS52Sdg@mail.gmail.com>
References: <1328025040-4751-1-git-send-email-kgene.kim@samsung.com>
 <1328025040-4751-2-git-send-email-kgene.kim@samsung.com>
 <20120131224043.GD8338@n2100.arm.linux.org.uk>
 <CAH9JG2W3Uk=J6GR4C6O6w-vkrG+b=j3ow5mEFbC21EFKS52Sdg@mail.gmail.com>
Message-ID: <06ae01cce720$ad9eb190$08dc14b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On 2/1/12, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > On Wed, Feb 01, 2012 at 12:50:39AM +0900, Kukjin Kim wrote:
> >> From: Sangsu Park <sangsu4u.park@samsung.com>
> >>
> >> This patch adds follwing.
> >> - IO-map for EXYNOS5250 GPIO support
> >> - EXYNOS5250 GPIO bank size/number definitions
> >> - memory map definition for S5P GPIO4
> >>
> >> Signed-off-by: Sangsu Park <sangsu4u.park@samsung.com>
> >> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> >
> > Do you actually need these static mapping definitions?  The samsung
> > gpiolib initialization is called from a core_initcall(), and at this
> > time ioremap() is fully capable of working.
> 
> If it assumes it has 8 gpios, you can make it simple calculate it like
> this.
> 
But unfortunately, it has not 8 gpios in each gpio bank.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> enum exynos5_gpios {
>      EXYNOS5_GPIO_A,
>      ...
> };
> 
> EXYNOS5_GPIO_A_START(n)          (EXYNOS5_GPIO_A * 8)
> 
> with this one, it can make a simple gpio driver when using irq domain for
> GPIO.
> 
