From: marc@cpdesign.com.au (Marc Reilly)
Date: Sun, 27 Feb 2011 16:18:17 +1100
Subject: [PATCH 1/2] ARM: imx35: fix ATA_DATA3 pad control address
In-Reply-To: <1298767313-16351-2-git-send-email-desrt@desrt.ca>
References: <1298767313-16351-1-git-send-email-desrt@desrt.ca>
	<1298767313-16351-2-git-send-email-desrt@desrt.ca>
Message-ID: <201102271618.17300.marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryan,

Good find!

> According to the "i.MX35 (MCIMX35) Multimedia Applications Processor
> Reference Manual" the correct address for the pad control register
> IOMUXC_SW_PAD_CTL_PAD_ATA_DATA3 is 0x06ec, not 0x6e8.
> 
> Signed-off-by: Ryan Lortie <desrt@desrt.ca>

Acked-by: Marc Reilly <marc@cpdesign.com.au>

Cheers
Marc

> ---
>  arch/arm/plat-mxc/include/mach/iomux-mx35.h |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx35.h
> b/arch/arm/plat-mxc/include/mach/iomux-mx35.h index 2a24bae..3117c18
> 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-mx35.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx35.h
> @@ -989,13 +989,13 @@
>  #define MX35_PAD_ATA_DATA2__IPU_DIAGB_9				IOMUX_PAD(0x6e8, 
0x284, 6, 0x0,
>   0, NO_PAD_CTRL) #define
> MX35_PAD_ATA_DATA2__ARM11P_TOP_TRACE_28			IOMUX_PAD(0x6e8, 0x284, 7, 
0x0, 
>  0, NO_PAD_CTRL)
> 
> -#define MX35_PAD_ATA_DATA3__ATA_DATA_3				IOMUX_PAD(0x6e8, 0x288, 
0, 0x0, 
>  0, NO_PAD_CTRL) -#define
> MX35_PAD_ATA_DATA3__ESDHC3_CLK				IOMUX_PAD(0x6e8, 0x288, 1, 
0x814, 1,
> NO_PAD_CTRL) -#define
> MX35_PAD_ATA_DATA3__USB_TOP_USBOTG_DATA_5		IOMUX_PAD(0x6e8, 0x288, 2,
> 0x9b8, 1, NO_PAD_CTRL) -#define
> MX35_PAD_ATA_DATA3__CSPI2_SCLK				IOMUX_PAD(0x6e8, 0x288, 4, 
0x7e0, 2,
> NO_PAD_CTRL) -#define MX35_PAD_ATA_DATA3__GPIO2_16				
IOMUX_PAD(0x6e8,
> 0x288, 5, 0x884, 1, NO_PAD_CTRL) -#define
> MX35_PAD_ATA_DATA3__IPU_DIAGB_10			IOMUX_PAD(0x6e8, 0x288, 6, 0x0,   0,
> NO_PAD_CTRL) -#define
> MX35_PAD_ATA_DATA3__ARM11P_TOP_TRACE_29			IOMUX_PAD(0x6e8, 0x288, 7, 
0x0, 
>  0, NO_PAD_CTRL) +#define
> MX35_PAD_ATA_DATA3__ATA_DATA_3				IOMUX_PAD(0x6ec, 0x288, 0, 0x0,   
0,
> NO_PAD_CTRL) +#define MX35_PAD_ATA_DATA3__ESDHC3_CLK				
IOMUX_PAD(0x6ec,
> 0x288, 1, 0x814, 1, NO_PAD_CTRL) +#define
> MX35_PAD_ATA_DATA3__USB_TOP_USBOTG_DATA_5		IOMUX_PAD(0x6ec, 0x288, 2,
> 0x9b8, 1, NO_PAD_CTRL) +#define
> MX35_PAD_ATA_DATA3__CSPI2_SCLK				IOMUX_PAD(0x6ec, 0x288, 4, 
0x7e0, 2,
> NO_PAD_CTRL) +#define MX35_PAD_ATA_DATA3__GPIO2_16				
IOMUX_PAD(0x6ec,
> 0x288, 5, 0x884, 1, NO_PAD_CTRL) +#define
> MX35_PAD_ATA_DATA3__IPU_DIAGB_10			IOMUX_PAD(0x6ec, 0x288, 6, 0x0,   0,
> NO_PAD_CTRL) +#define
> MX35_PAD_ATA_DATA3__ARM11P_TOP_TRACE_29			IOMUX_PAD(0x6ec, 0x288, 7, 
0x0, 
>  0, NO_PAD_CTRL)
> 
>  #define MX35_PAD_ATA_DATA4__ATA_DATA_4				IOMUX_PAD(0x6f0, 0x28c, 
0, 0x0, 
>  0, NO_PAD_CTRL) #define
> MX35_PAD_ATA_DATA4__ESDHC3_CMD				IOMUX_PAD(0x6f0, 0x28c, 1, 
0x818, 1,
> NO_PAD_CTRL)
