From: tony@atomide.com (Tony Lindgren)
Date: Thu, 25 Aug 2011 19:03:48 +0300
Subject: [PATCH v2 0/7] omap: iommu migration, relocation and cleanups
In-Reply-To: <1314205694-28935-1-git-send-email-ohad@wizery.com>
References: <1314205694-28935-1-git-send-email-ohad@wizery.com>
Message-ID: <20110825160348.GZ4996@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ohad Ben-Cohen <ohad@wizery.com> [110824 19:36]:
> 1. Migrate OMAP's iommu driver to the generic IOMMU API, and move it
> to the dedicated iommu folder.
> 
> 2. Fix omap3isp appropriately so it doesn't break.
> 
> 3. Adapt OMAP's iovmm appropriately as well, because omap3isp still relies
> on it. The plan is eventually to remove iovmm and replace it with the
> upcoming IOMMU-based generic DMA-API. Move iovmm to the iommu folder too;
> it belongs there more than it belongs in the OMAP folders.
> 
> 4. Start cleaning up OMAP's iommu components towards the end goal, where
>     1) omap-iommu no longer exports public API (and instead provides its
>        entire functionality via the generic IOMMU API).
>     2) omap-iovmm is removed.
> 
> Tested on OMAP3 (with omap3isp) and OMAP4 (with rpmsg/remoteproc).

Glad to see this, thanks for doing this! For all the patches:

Acked-by: Tony Lindgren <tony@atomide.com>
