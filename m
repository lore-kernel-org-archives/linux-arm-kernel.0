From: h-kanigeri2@ti.com (Kanigeri, Hari)
Date: Mon, 27 Sep 2010 11:28:38 -0500
Subject: [PATCH 05/11] omap3: Remove non-existent config option
In-Reply-To: <AANLkTim9Y3i7M9Jjo6RZs7zMNVZUkFm1P7P=h0y2J=Nj@mail.gmail.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
	<20100924015056.10325.95854.stgit@baageli.muru.com>
	<AANLkTik+Qgn5dYd+p_PvEUQFhcwQ2NVxW-fhEdurO6s+@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F70753CB@dbde02.ent.ti.com>
	<AANLkTinF=iV8p=jmg-YntCpX_BHmavLD3gu2LhhBFRq6@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930233C361B4@dbde02.ent.ti.com>
	<AANLkTim9Y3i7M9Jjo6RZs7zMNVZUkFm1P7P=h0y2J=Nj@mail.gmail.com>
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E5F6A365B@dlee03.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe,

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Felipe Contreras
> Sent: Monday, September 27, 2010 10:56 AM
> To: Marathe, Yogesh
> Cc: Premi, Sanjeev; Tony Lindgren; linux-arm-kernel at lists.infradead.org;
> linux-omap at vger.kernel.org
> Subject: Re: [PATCH 05/11] omap3: Remove non-existent config option
> 
> On Mon, Sep 27, 2010 at 2:02 PM, Marathe, Yogesh <yogesh_marathe@ti.com>
> wrote:
> >> When you merge iommu support, then either you enable
> >> CONFIG_MPU_BRIDGE_IOMMU unconditionally, or you apply this patch, but
> >> this patch alone will only break things.
> >
> > Any other driver which does not depend on bridge and interested in using
> iommu should get the handle when iommu_get("iva2") is called.
> 
> That's a hypothetical driver, right? The only driver that would ever
> be interested in the "iva2" iommu is tidspbridge, and this patch would
> brake it.
> 
> > It is not happening in original case. I think there should not be
> restrictions on other drivers to define un-related compile time define if
> they just want to use iommu driver. I feel the implementation that is
> breaking due to removal of this define should be fixed.
> 
> I couldn't parse that correctly. However, what's wrong with the
> proposal? Let's think about CONFIG_MPU_BRIDGE_IOMMU when the iommu
> patches come.
> 

Yogesh is coming from dsplink requirement to use iommu. I see his comment as why Bridge requirement should be imposed on other IPCs that need iommu.

Thank you,
Best regards,
Hari
