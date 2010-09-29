From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Wed, 29 Sep 2010 14:34:36 +0300
Subject: [PATCH 05/11] omap3: Remove non-existent config option
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E5F6A365B@dlee03.ent.ti.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
	<20100924015056.10325.95854.stgit@baageli.muru.com>
	<AANLkTik+Qgn5dYd+p_PvEUQFhcwQ2NVxW-fhEdurO6s+@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F70753CB@dbde02.ent.ti.com>
	<AANLkTinF=iV8p=jmg-YntCpX_BHmavLD3gu2LhhBFRq6@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930233C361B4@dbde02.ent.ti.com>
	<AANLkTim9Y3i7M9Jjo6RZs7zMNVZUkFm1P7P=h0y2J=Nj@mail.gmail.com>
	<8F7AF80515AF0D4D93307E594F3CB40E5F6A365B@dlee03.ent.ti.com>
Message-ID: <AANLkTimD_MRbuTnBMPzAKPTmrDwjLkLVmr9bTSNROb5L@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hari,

On Mon, Sep 27, 2010 at 7:28 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
> Yogesh is coming from dsplink requirement to use iommu. I see his comment as why Bridge requirement should be imposed on other IPCs that need iommu.

Ahh, that explains a lot. However, dsp-link can just enable
CONFIG_MPU_BRIDGE_IOMMU, and that's it, right? Perhaps it would make
sense to rename to CONFIG_OMAP_IOMMU_IVA2, or something like that. But
not remove it and break tidspbridge, which is already in staging.

Once both are working happily with CONFIG_OMAP_IOMMU_IVA2 on, _then_
it can be removed.

-- 
Felipe Contreras
