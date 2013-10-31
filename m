From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 31 Oct 2013 08:29:07 +0100
Subject: [PATCH v2 1/4] dma: imx-sdma: Add sdma firmware version 2 support
In-Reply-To: <cfe6edbff010aefc8a35df8a719b26bd238cb3cc.1383197521.git.b42378@freescale.com>
References: <cover.1383197521.git.b42378@freescale.com>
 <cfe6edbff010aefc8a35df8a719b26bd238cb3cc.1383197521.git.b42378@freescale.com>
Message-ID: <20131031072907.GG24559@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 02:32:03PM +0800, Nicolin Chen wrote:
> On i.MX5/6 series, SDMA is using new version firmware to support SSI
> dual FIFO feature and HDMI Audio (i.MX6Q/DL only). Thus add it.
> 
> Signed-off-by: Nicolin Chen <b42378@freescale.com>
> ---
> diff --git a/include/linux/platform_data/dma-imx-sdma.h b/include/linux/platform_data/dma-imx-sdma.h
> index 3a39428..14ca582 100644
> --- a/include/linux/platform_data/dma-imx-sdma.h
> +++ b/include/linux/platform_data/dma-imx-sdma.h
> @@ -43,6 +43,9 @@ struct sdma_script_start_addrs {
>  	s32 dptc_dvfs_addr;
>  	s32 utra_addr;
>  	s32 ram_code_start_addr;

You could add a comment here, like: /* End of v1 array */

Otherwise:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> +	s32 mcu_2_ssish_addr;
> +	s32 ssish_2_mcu_addr;
> +	s32 hdmi_dma_addr;
>  };
>  
>  /**
> -- 
> 1.8.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
