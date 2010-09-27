From: tony@atomide.com (Tony Lindgren)
Date: Mon, 27 Sep 2010 09:24:20 -0700
Subject: [PATCH 05/11] omap3: Remove non-existent config option
In-Reply-To: <AANLkTim9Y3i7M9Jjo6RZs7zMNVZUkFm1P7P=h0y2J=Nj@mail.gmail.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
	<20100924015056.10325.95854.stgit@baageli.muru.com>
	<AANLkTik+Qgn5dYd+p_PvEUQFhcwQ2NVxW-fhEdurO6s+@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F70753CB@dbde02.ent.ti.com>
	<AANLkTinF=iV8p=jmg-YntCpX_BHmavLD3gu2LhhBFRq6@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930233C361B4@dbde02.ent.ti.com>
	<AANLkTim9Y3i7M9Jjo6RZs7zMNVZUkFm1P7P=h0y2J=Nj@mail.gmail.com>
Message-ID: <20100927162420.GU4211@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Contreras <felipe.contreras@gmail.com> [100927 08:47]:
> On Mon, Sep 27, 2010 at 2:02 PM, Marathe, Yogesh <yogesh_marathe@ti.com> wrote:
> >> When you merge iommu support, then either you enable
> >> CONFIG_MPU_BRIDGE_IOMMU unconditionally, or you apply this patch, but
> >> this patch alone will only break things.
> >
> > Any other driver which does not depend on bridge and interested in using iommu should get the handle when iommu_get("iva2") is called.
> 
> That's a hypothetical driver, right? The only driver that would ever
> be interested in the "iva2" iommu is tidspbridge, and this patch would
> brake it.
> 
> > It is not happening in original case. I think there should not be restrictions on other drivers to define un-related compile time define if they just want to use iommu driver. I feel the implementation that is breaking due to removal of this define should be fixed.
> 
> I couldn't parse that correctly. However, what's wrong with the
> proposal? Let's think about CONFIG_MPU_BRIDGE_IOMMU when the iommu
> patches come.

Let's not break the existing code. Dropping this patch for now.

Tony
