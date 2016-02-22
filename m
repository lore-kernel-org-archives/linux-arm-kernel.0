From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 22 Feb 2016 15:06:55 +0530
Subject: [PATCH 1/5] ARM: davinci: devices-da8xx: Add dma_slave_map to edma
In-Reply-To: <1454416997-14230-2-git-send-email-peter.ujfalusi@ti.com>
References: <1454416997-14230-1-git-send-email-peter.ujfalusi@ti.com>
 <1454416997-14230-2-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <56CAD6B7.2030706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 February 2016 06:13 PM, Peter Ujfalusi wrote:

> +static const struct dma_slave_map da850_edma1_map[] = {
> +	{ "da830-mmc.1", "rx", EDMA_FILTER_PARAM(0, 28) },
> +	{ "da830-mmc.1", "tx", EDMA_FILTER_PARAM(0, 29) },

This should be EDMA_FILTER_PARAM(1, 29) (and similar for rx). No need to
resend though, I will fix while applying.

Regards,
Sekhar
