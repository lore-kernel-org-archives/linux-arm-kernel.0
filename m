From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 09 Feb 2012 20:39:41 +0900
Subject: [PATCH 3/9] ARM: EXYNOS: add initial setup-i2c0 for EXYNOS5
In-Reply-To: <CAOesGMg3xS7o1+F1ZmZvg1=oy59F+7QnSYWkJ9kTacCDu35aOg@mail.gmail.com>
References: <1328024354-4277-1-git-send-email-kgene.kim@samsung.com>
 <1328024354-4277-4-git-send-email-kgene.kim@samsung.com>
 <CAOesGMg3xS7o1+F1ZmZvg1=oy59F+7QnSYWkJ9kTacCDu35aOg@mail.gmail.com>
Message-ID: <06a001cce71f$82dd10b0$88973210$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> Hi,
> 
Hi :)

> On Tue, Jan 31, 2012 at 7:39 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> A brief patch description, please.
> 
OK. Will add, I thought we don't need same description with subject. But
what this patch is and why this patch is needed will be added next time.

[...]

> > - * linux/arch/arm/mach-exynos4/setup-i2c0.c
> > + * linux/arch/arm/mach-exynos/setup-i2c0.c
> 
> The file name fills very little purpose in files like these. Consider
> removing them at some point.
> 
Yes, agree. Firstly, it will be removed when it is updated from now on.

[...]

> > ?void s3c_i2c0_cfg_gpio(struct platform_device *dev)
> > ?{
> > - ? ? ? s3c_gpio_cfgall_range(EXYNOS4_GPD1(0), 2,
> > - ? ? ? ? ? ? ? ? ? ? ? ? ? ? S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
> > + ? ? ? if (soc_is_exynos5250())
> > + ? ? ? ? ? ? ? ;
> > + ? ? ? ? ? ? ? /* will be implemented with gpio function */
> > + ? ? ? else
> > + ? ? ? ? ? ? ? s3c_gpio_cfgall_range(EXYNOS4_GPD1(0), 2,
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? S3C_GPIO_SFN(2),
S3C_GPIO_PULL_UP);
> > ?}
> 
> The above is pretty awkward. It's cleaner to return and avoid the else
> side of the statement (move the comment accordingly, of course).
> 
OK.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
