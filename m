From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Feb 2011 15:33:00 +0000
Subject: [PATCH 1/5] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <1296871696-21008-2-git-send-email-shawn.guo@freescale.com>
References: <1296871696-21008-1-git-send-email-shawn.guo@freescale.com>
	<1296871696-21008-2-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110205153300.GA29411@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

A couple more points below.

On Sat, Feb 05, 2011 at 10:08:12AM +0800, Shawn Guo wrote:
> +	mxs_dma->dev = &pdev->dev;
...
> +	mxs_dma->dma_device.dev = &pdev->dev;

Do you need mxs_dma->dev, or could you just use mxs_dma->dma_device.dev
throughout?

> +static int __exit mxs_dma_remove(struct platform_device *pdev)
> +{
> +	return -EBUSY;
> +}

As the return code is ignored, it's probably better to omit the remove
function entirely.
