From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Jun 2011 14:25:33 +0100
Subject: [PATCH 5/8 v2] ARM i.MX Allow to compile together i.MX1/21/25/27
In-Reply-To: <20110601132206.GF23771@pengutronix.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<1305823648-2428-6-git-send-email-s.hauer@pengutronix.de>
	<20110601132206.GF23771@pengutronix.de>
Message-ID: <20110601132533.GH3660@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2011 at 03:22:06PM +0200, Sascha Hauer wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 9adc278..89c3f16 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -193,7 +193,6 @@ config VECTORS_BASE
>  
>  config ARM_PATCH_PHYS_VIRT
>  	bool "Patch physical to virtual translations at runtime (EXPERIMENTAL)"
> -	depends on EXPERIMENTAL

Please make this a separate patch - which also removes the (EXPERIMENTAL)
suffix as well.  Options which are experimental are supposed to have that
tag in the text, options which aren't must not have the tag.
