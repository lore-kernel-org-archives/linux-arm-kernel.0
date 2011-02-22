From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 22 Feb 2011 20:34:13 +0800
Subject: [PATCH v3 2/2] ARM: mxs: add dma device
In-Reply-To: <20110222075241.GU24426@pengutronix.de>
References: <1298284306-14710-1-git-send-email-shawn.guo@freescale.com>
	<1298284306-14710-3-git-send-email-shawn.guo@freescale.com>
	<20110222075241.GU24426@pengutronix.de>
Message-ID: <20110222123412.GE19871@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Tue, Feb 22, 2011 at 08:52:41AM +0100, Sascha Hauer wrote:
> On Mon, Feb 21, 2011 at 06:31:46PM +0800, Shawn Guo wrote:
> 
> Being consistent is one thing, but this should not lead to ifdeffery
> where not necessary. Wouldn't it be much simpler to do the following:
> 
> static struct platform_device * __init mxs_add_dma(const char *devid,
> 		resource_size_t base)
> {
> 	struct resource res_apbh[] = {
> 		{
> 			.start = base,
> 			.end = base + SZ_8K - 1,
> 			.flags = IORESOURCE_MEM,
> 		},
> 	};
> 
> 	return mxs_add_platform_device_dmamask(devid, -1,
> 				res, ARRAY_SIZE(res), NULL, 0,
> 				DMA_BIT_MASK(32));
> }
> 
> static int __init mxs_add_mxs_dma(void)
> {
> 	char *apbh = "mxs-dma-apbh";
> 	char *apbx = "mxs-dma-apbx";
> 
> 	if (cpu_is_mx23()) {
> 		mxs_add_dma(apbh, MX23_APBH_DMA_BASE_ADDR);
> 		mxs_add_dma(apbx, MX23_APBX_DMA_BASE_ADDR);
> 	}
> 
> 	if (cpu_is_mx28()) {
> 		mxs_add_dma(apbh, MX28_APBH_DMA_BASE_ADDR);
> 		mxs_add_dma(apbx, MX28_APBX_DMA_BASE_ADDR);
> 	}
> 
> 	return 0;
> }
> arch_initcall(mxs_add_mxs_dma);
> 
> No ifdef, clear to read and only half the size.
> 
Looks sane.  Thanks.

-- 
Regards,
Shawn
