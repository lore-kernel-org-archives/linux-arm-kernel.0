From: GNUtoo@no-log.org (Denis 'GNUtoo' Carikli)
Date: Fri, 11 Feb 2011 22:13:36 +0100
Subject: [PATCH] mx31: add support for the bugbase 1.3 from buglabs
In-Reply-To: <1297458388-23361-1-git-send-email-GNUtoo@no-log.org>
References: <20110211081050.GD27982@pengutronix.de>
	<1297458388-23361-1-git-send-email-GNUtoo@no-log.org>
Message-ID: <1297458816.18578.5.camel@gnutoo-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
> index e634d6c..b45f534 100644
> --- a/arch/arm/plat-mxc/include/mach/uncompress.h
> +++ b/arch/arm/plat-mxc/include/mach/uncompress.h
> @@ -62,6 +62,7 @@ static inline void flush(void)
>  #define MX2X_UART1_BASE_ADDR	0x1000a000
>  #define MX3X_UART1_BASE_ADDR	0x43F90000
>  #define MX3X_UART2_BASE_ADDR	0x43F94000
> +#define MX3X_UART5_BASE_ADDR	0x43FB4000
>  #define MX51_UART1_BASE_ADDR	0x73fbc000
>  #define MX50_UART1_BASE_ADDR	0x53fbc000
>  #define MX53_UART1_BASE_ADDR	0x53fbc000
> @@ -102,6 +103,9 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
>  	case MACH_TYPE_MAGX_ZN5:
>  		uart_base = MX3X_UART2_BASE_ADDR;
>  		break;
> +	case MACH_TYPE_BUG:
> +		uart_base = MX3X_UART5_BASE_ADDR;
> +		break;
>  	case MACH_TYPE_MX51_BABBAGE:
>  	case MACH_TYPE_EUKREA_CPUIMX51SD:
>  	case MACH_TYPE_MX51_3DS:
That seem not to crash, but I wonder if it's really useful:
Basically I see u-boot loading the kernel, then I have
> Uncompressing Linux... 
Then I wait some seconds
Then I see that line beeing complretted with:
> done, booting the kernel.
Then the rest of the messages are displayed very fast,
along with initramfs loading messages and I finally get a shell.

Denis.
