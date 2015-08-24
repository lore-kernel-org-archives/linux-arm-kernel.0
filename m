From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Aug 2015 21:59:51 +0200
Subject: [PATCH 1/3] ARM: uniphier: add outer cache support
In-Reply-To: <1440382692-3855-2-git-send-email-yamada.masahiro@socionext.com>
References: <1440382692-3855-1-git-send-email-yamada.masahiro@socionext.com>
 <1440382692-3855-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <2021253.vgeYqalDfp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 August 2015 11:18:10 Masahiro Yamada wrote:
> diff --git a/Documentation/devicetree/bindings/arm/uniphier/cache-uniphier.txt b/Documentation/devicetree/bindings/arm/uniphier/cache-uniphier.txt
> new file mode 100644
> index 0000000..6428289
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/uniphier/cache-uniphier.txt
> @@ -0,0 +1,30 @@
> +UniPhier outer cache controller
> +
> +UniPhier SoCs are integrated with a level 2 cache controller that resides
> +outside of the ARM cores, some of them also have a level 3 cache controller.
> +
> +Required properties:
> +- compatible: should be one of the followings:
> +       "socionext,uniphier-l2-cache"   (L2 cache)
> +       "socionext,uniphier-l3-cache"   (L3 cache)
> +- reg: offsets and lengths of the register sets for the device.  It should
> +  contain 3 regions: control registers, revision registers, operation
> +  registers, in this order.
> +
> +The L2 cache must exist to use the L3 cache; adding only an L3 cache device
> +node to the device tree causes the initialization failure of the whole outer
> +cache system.
> 

How much does this outer cache have in common with the l2x0/pl310 cache
controller model? Would it make sense to at least share the
common entry point at l2x0_of_init() so you don't need to call it from
the platform file?

	Arnd
