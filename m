From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 16 May 2012 08:58:27 +0800
Subject: [PATCH 3/8] MXS: Fixup i.MX233 USB base address name
In-Reply-To: <1337070219-3630-4-git-send-email-marex@denx.de>
References: <1337070219-3630-1-git-send-email-marex@denx.de>
 <1337070219-3630-4-git-send-email-marex@denx.de>
Message-ID: <20120516005826.GH29393@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 10:23:34AM +0200, Marek Vasut wrote:
> Modify USB EHCI and USB PHY base addresses on the i.MX233 to nicely fit into the
> whole USB registration scheme.
> 
> Based on code by:
> Tony Lin <tony.lin@freescale.com>
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Chen Peter-B29397 <B29397@freescale.com>
> Cc: Detlev Zundel <dzu@denx.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Li Frank-B20596 <B20596@freescale.com>
> Cc: Linux USB <linux-usb@vger.kernel.org>
> Cc: Liu JunJie-B08287 <B08287@freescale.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Shi Make-B15407 <B15407@freescale.com>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Subodh Nijsure <snijsure@grid-net.com>
> Cc: Wolfgang Denk <wd@denx.de>
> ---
>  arch/arm/mach-mxs/include/mach/mx23.h |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/include/mach/mx23.h b/arch/arm/mach-mxs/include/mach/mx23.h
> index 599094b..7955b75 100644
> --- a/arch/arm/mach-mxs/include/mach/mx23.h
> +++ b/arch/arm/mach-mxs/include/mach/mx23.h
> @@ -64,8 +64,8 @@
>  #define MX23_AUART1_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x06c000)
>  #define MX23_AUART2_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x06e000)
>  #define MX23_DUART_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x070000)
> -#define MX23_USBPHY_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x07c000)
> -#define MX23_USBCTRL_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x080000)
> +#define MX23_USBPHY0_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x07c000)
> +#define MX23_USBCTRL0_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x080000)
Why not migrate to DT?

Thanks
Richard
>  #define MX23_DRAM_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x0e0000)
>  
>  #define MX23_IO_P2V(x)			MXS_IO_P2V(x)
> @@ -89,8 +89,8 @@
>  #define MX23_INT_SPDIF_ERROR		10
>  #define MX23_INT_SAIF1_IRQ		10
>  #define MX23_INT_SAIF2_IRQ		10
> -#define MX23_INT_USB_CTRL		11
> -#define MX23_INT_USB_WAKEUP		12
> +#define MX23_INT_USB0			11
> +#define MX23_INT_USB0_WAKEUP		12
>  #define MX23_INT_GPMI_DMA		13
>  #define MX23_INT_SSP1_DMA		14
>  #define MX23_INT_SSP1_ERROR		15
> -- 
> 1.7.10
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
