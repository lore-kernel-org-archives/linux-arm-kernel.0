From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Apr 2016 16:31:53 +0100
Subject: [PATCH] ARM: mach-imx: sdhci-esdhc-imx: initialize DMA mask
In-Reply-To: <570CE920.4040204@nvidia.com>
References: <1460362846-2906-1-git-send-email-akurz@blala.de>
 <20160411083510.GN10108@pengutronix.de>
 <570B780E.7090801@intel.com>
 <alpine.DEB.2.00.1604111803080.6072@blala.de>
 <570C902E.7090607@intel.com>
 <20160412084048.GM19428@n2100.arm.linux.org.uk>
 <570CC6F2.4090301@intel.com> <570CE920.4040204@nvidia.com>
Message-ID: <20160412153153.GO19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2016 at 09:25:04PM +0900, Alexandre Courbot wrote:
> Clearly these devices need to be fixed. If we want to give them a grace
> period, we could also (temporarily) not propagate the return value of
> dma_set_mask_and_coherent() and limit ourselves to emitting a big warning
> about the inconsistency of having SDHCI_USE_SDMA/SDHCI_USE_ADMA in the host
> flags while not setting a dma mask.

Isn't it just easier to fix the root problem?  It'll be one patch.

There's no need to add churn by changing sdhci stuff, then fixing the
imx stuff, and then reverting the sdhci changes.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
