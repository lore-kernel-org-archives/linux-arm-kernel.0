From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Jul 2014 15:21:35 +0100
Subject: [PATCH] bus: ARM CCN PMU driver
In-Reply-To: <1405088056-29181-1-git-send-email-pawel.moll@arm.com>
References: <1405088056-29181-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20140711142135.GA21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 03:14:16PM +0100, Pawel Moll wrote:
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index 1f37d98..6ab2a62 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -4,14 +4,6 @@
>  
>  menu "Bus devices"
>  
> -config BRCMSTB_GISB_ARB
> -	bool "Broadcom STB GISB bus arbiter"
> -	depends on ARM
> -	help
> -	  Driver for the Broadcom Set Top Box System-on-a-chip internal bus
> -	  arbiter. This driver provides timeout and target abort error handling
> -	  and internal bus master decoding.
> -
...
> diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
> index 6a4ea7e..493b4ff 100644
> --- a/drivers/bus/Makefile
> +++ b/drivers/bus/Makefile
> @@ -2,14 +2,15 @@
>  # Makefile for the bus drivers.
>  #
>  
> -obj-$(CONFIG_BRCMSTB_GISB_ARB)	+= brcmstb_gisb.o

I assume that as these exist in the patch, you haven't looked through
the patch to check what you're actually submitting... how can we be
sure that the rest of the patch is what you intend to submit?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
