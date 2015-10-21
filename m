From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Oct 2015 16:40:02 -0700
Subject: [PATCH v3 01/10] ARM: cygnus: fix link failures when
 CONFIG_COMMON_CLK_IPROC is disabled
In-Reply-To: <1444938513-10758-2-git-send-email-jonmason@broadcom.com>
References: <1444938513-10758-1-git-send-email-jonmason@broadcom.com>
 <1444938513-10758-2-git-send-email-jonmason@broadcom.com>
Message-ID: <20151021234002.GN19782@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15, Jon Mason wrote:
> diff --git a/drivers/clk/bcm/Kconfig b/drivers/clk/bcm/Kconfig
> index 88febf5..46ee475 100644
> --- a/drivers/clk/bcm/Kconfig
> +++ b/drivers/clk/bcm/Kconfig
> @@ -9,10 +9,8 @@ config CLK_BCM_KONA
>  	  in the BCM281xx and BCM21664 families.
>  
>  config COMMON_CLK_IPROC
> -	bool "Broadcom iProc clock support"
> -	depends on ARCH_BCM_IPROC

Another patch added COMPILE_TEST here, so I've removed
COMPILE_TEST now.

Applied to clk-next.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
