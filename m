From: pullip.cho@samsung.com (Cho KyongHo)
Date: Mon, 17 Mar 2014 09:26:46 +0900
Subject: [PATCH v11 01/27] iommu/exynos: do not include removed header
In-Reply-To: <CAK9yfHyGfdP+0RKtdSCdU4tO=PX8GbQRQ7ar=ST5B2RenZMMsg@mail.gmail.com>
References: <20140314140129.68a41cc1bd9e0a48a198ca13@samsung.com>
 <CAK9yfHzRasE3jroDUZgAa=DN5N=2ZDAxgNiHDCip+f2868BAVQ@mail.gmail.com>
 <000e01cf3f7b$6edcdfd0$4c969f70$@samsung.com>
 <CAK9yfHyGfdP+0RKtdSCdU4tO=PX8GbQRQ7ar=ST5B2RenZMMsg@mail.gmail.com>
Message-ID: <20140317092646.b696d2245fb95ea8835cbd2e@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Mar 2014 17:29:36 +0530, Sachin Kamat wrote:
> On 14 March 2014 17:19, Cho KyongHo <pullip.cho@samsung.com> wrote:
> >> From: Sachin Kamat [mailto:sachin.kamat at linaro.org]
> >> Sent: Friday, March 14, 2014 7:00 PM
> >>
> >> On 14 March 2014 10:31, Cho KyongHo <pullip.cho@samsung.com> wrote:
> >> > Commit 25e9d28d92 (ARM: EXYNOS: remove system mmu initialization from
> >> > exynos tree) removed arch/arm/mach-exynos/mach/sysmmu.h header without
> >> > removing remaining use of it from exynos-iommu driver, thus causing a
> >> > compilation error.
> >> >
> >> > This patch fixes the error by removing respective include line
> >> > from exynos-iommu.c.
> >> >
> >> > CC: Tomasz Figa <t.figa@samsung.com>
> >> > Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> >> > ---
> >> >  drivers/iommu/exynos-iommu.c |    3 +--
> >> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >> >
> >> > diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> >> > index 0740189..4876d35 100644
> >> > --- a/drivers/iommu/exynos-iommu.c
> >> > +++ b/drivers/iommu/exynos-iommu.c
> >> > @@ -12,6 +12,7 @@
> >> >  #define DEBUG
> >> >  #endif
> >> >
> >> > +#include <linux/kernel.h>
> >>
> >> This change doesn't look related to the patch subject/description.
> >>
> > Yes. But it is simply added without any side-effect.
> > Do you think it should be in a separate patch?.
> > Actually, the added line is a redundant.
> 
> If it is redundant, then you shouldn't be adding it. If it is
> required, then please
> mention about the need in the commit description if not a separate patch.
> 

Ok.

Thanks for the advice.

KyongHo
