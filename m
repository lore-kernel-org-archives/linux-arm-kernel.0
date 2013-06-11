From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 11 Jun 2013 19:05:22 +0900
Subject: About LPAE supporting on EXYNOS5440
In-Reply-To: <6690814.Wx0lSuVAQ5@wuerfel>
References: <109e01ce667e$5becc880$13c65980$%kim@samsung.com>
 <6690814.Wx0lSuVAQ5@wuerfel>
Message-ID: <10b001ce668b$2fdddec0$8f999c40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Tuesday 11 June 2013 17:33:33 Kukjin Kim wrote:
> > Hi all,
> >
> > The exynos5440 can support LPAE and referece boards, SSDK5440 and SD5v1
> have
> > over 8GiB memory.
> >
> > Current exynos_defconfig selects every EXYNOS SoCs including exynos5440
> it
> > means supporting LPAE will be selected for other EXYNOS SoCs.
> >
> > I'm wondering if seleting LPAE causes some problem for multiplatform.
> Can we
> > support LPAE enabled and disabled platform together with single zImage?
> 
> No, that isn't possible.

Yeah, I know that.

> I think we should enable all exynos support in
> the
> regular multi_v7_defconfig and leave LPAE turned off for that,

But if so, problem will happen in the memory parsing without LPAE
enabling...so I'm wondering I should deselect exynos5440 in the defconfig
for other exynos SoCs...

> but create
> another multi_lpae_defconfig that has all LPAE capable machines turned on.
> This is also what I expect the distros to do.
> 
Yeah, it could be a solution for multiplatform at this moment. And if so,
probably I should deselect exynos5440 in the exynos_defconfig and need to
add another defconfig for exynos lpae stuff.

BTW, do you know what SoCs can support LPAE now?

Thanks,
Kukjin
