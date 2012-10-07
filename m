From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 7 Oct 2012 09:23:03 +0100
Subject: [PATCH] ARM: OMAP: Fix dependency for OMAP_DEBUG_LEDS
In-Reply-To: <1349596837.15349.2.camel@phoenix>
References: <1349596837.15349.2.camel@phoenix>
Message-ID: <20121007082303.GD28061@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 07, 2012 at 04:00:37PM +0800, Axel Lin wrote:
>  config OMAP_DEBUG_LEDS
> -	def_bool y if NEW_LEDS
> +	default y if LEDS_CLASS
>  	depends on OMAP_DEBUG_DEVICES

This change is wrong.  You're making this config entry untyped.
