From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Mar 2015 20:24:46 +0000
Subject: [PATCH v3 5/7] dmaengine: omap-dma: Take DMA request number from
 DT if it is available
In-Reply-To: <1427459213-14611-6-git-send-email-peter.ujfalusi@ti.com>
References: <1427459213-14611-1-git-send-email-peter.ujfalusi@ti.com>
 <1427459213-14611-6-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20150327202446.GB4027@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 27, 2015 at 02:26:51PM +0200, Peter Ujfalusi wrote:
> +	if (!pdev->dev.of_node || of_property_read_u32(pdev->dev.of_node,
> +						       "dma-requests",
> +						       &od->dma_requests)) {
> +		dev_info(&pdev->dev,
> +			 "Missing dma-requests property, using %u.\n",
> +			 OMAP_SDMA_REQUESTS);
> +		od->dma_requests = OMAP_SDMA_REQUESTS;
> +	}

Are all OMAPs including OMAP1 being converted to DT?  If not, don't
introduce noisy printks for which a platform can't do anything about.
Think about this please - if there's no of_node, then why complain
about a missing OF property?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
