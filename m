From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Jun 2013 17:11:12 -0700
Subject: About LPAE supporting on EXYNOS5440
In-Reply-To: <6690814.Wx0lSuVAQ5@wuerfel>
References: <109e01ce667e$5becc880$13c65980$%kim@samsung.com>
 <6690814.Wx0lSuVAQ5@wuerfel>
Message-ID: <20130612001112.GK23774@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 11:53:36AM +0200, Arnd Bergmann wrote:
> On Tuesday 11 June 2013 17:33:33 Kukjin Kim wrote:
> > Hi all,
> > 
> > The exynos5440 can support LPAE and referece boards, SSDK5440 and SD5v1 have
> > over 8GiB memory.
> > 
> > Current exynos_defconfig selects every EXYNOS SoCs including exynos5440 it
> > means supporting LPAE will be selected for other EXYNOS SoCs.
> > 
> > I'm wondering if seleting LPAE causes some problem for multiplatform. Can we
> > support LPAE enabled and disabled platform together with single zImage?
> 
> No, that isn't possible. I think we should enable all exynos support in the
> regular multi_v7_defconfig and leave LPAE turned off for that, but create
> another multi_lpae_defconfig that has all LPAE capable machines turned on.
> This is also what I expect the distros to do.

I think it would be unfortunate to split the defconfig just for LPAE,
since all the other parts should be identical (drivers, etc).

I wonder if it makes more sense to just include a config fragment to
turn on LPAE together with the existing multi_v7_defconfig.


-Olof
