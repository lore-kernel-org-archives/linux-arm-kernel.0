From: linuxzsc@gmail.com (Richard Zhao)
Date: Fri, 11 Feb 2011 20:25:05 +0800
Subject: [PATCH v2] i.MX51 iomux: Fixes MX51_PAD_UART2_TXD__UART2_TXD
	declaration
In-Reply-To: <1297420916-14505-1-git-send-email-julien.boibessot@free.fr>
References: <1297420916-14505-1-git-send-email-julien.boibessot@free.fr>
Message-ID: <20110211122505.GB1866@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

#define _MX51_PAD_USBH1_DATA2__UART2_TXD	IOMUX_PAD(0x690, 0x290, 1, 0x09ec, 5, 0)

Will you change the above line too?

Thanks
Richard

On Fri, Feb 11, 2011 at 11:41:56AM +0100, julien.boibessot at free.fr wrote:
> From: Julien Boibessot <julien.boibessot@armadeus.com>
> 
> Fixes a regression of recent iomux changes: current MX51_PAD_UART2_TXD__UART2_TXD
> declaration overwrites IOMUXC_UART2_IPP_UART_RXD_MUX_SELECT_INPUT register
> (0x09ec) and prevent UART2 Rx from working properly.
> (Tested on my custom i.MX51 board where UART2 is used as console)
> 
> Signed-off-by: Julien Boibessot <julien.boibessot@armadeus.com>
> ---
> Changes since v1:
>     - Improve patch description as requested by Sascha Hauer
> 
>  arch/arm/plat-mxc/include/mach/iomux-mx51.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> index b6767f9..df531aa 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> @@ -473,7 +473,7 @@
>  #define _MX51_PAD_UART2_RXD__UART2_RXD		IOMUX_PAD(0x628, 0x238, 0, 0x09ec, 2, 0)
>  #define _MX51_PAD_UART2_TXD__FIRI_RXD		IOMUX_PAD(0x62c, 0x23c, 1, 0x0000, 0, 0)
>  #define _MX51_PAD_UART2_TXD__GPIO1_21		IOMUX_PAD(0x62c, 0x23c, 3, 0x0000, 0, 0)
> -#define _MX51_PAD_UART2_TXD__UART2_TXD		IOMUX_PAD(0x62c, 0x23c, 0, 0x09ec, 3, 0)
> +#define _MX51_PAD_UART2_TXD__UART2_TXD		IOMUX_PAD(0x62c, 0x23c, 0, 0x0000, 0, 0)
>  #define _MX51_PAD_UART3_RXD__CSI1_D0		IOMUX_PAD(0x630, 0x240, 2, 0x0000, 0, 0)
>  #define _MX51_PAD_UART3_RXD__GPIO1_22		IOMUX_PAD(0x630, 0x240, 3, 0x0000, 0, 0)
>  #define _MX51_PAD_UART3_RXD__UART1_DTR		IOMUX_PAD(0x630, 0x240, 0, 0x0000, 0, 0)
> -- 
> 1.6.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
