From: robh@kernel.org (Rob Herring)
Date: Tue, 28 Nov 2017 09:25:41 -0600
Subject: [PATCH] dt-bindings: uniphier: add bindings for UniPhier SoC
 family
In-Reply-To: <1511854150-26346-1-git-send-email-yamada.masahiro@socionext.com>
References: <1511854150-26346-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20171128152541.jdd2k5n5mjpppqxv@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 04:29:10PM +0900, Masahiro Yamada wrote:

Commit msg?

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  Documentation/devicetree/bindings/arm/uniphier.txt | 40 ++++++++++++++++++++++

Perhaps arm/socionext/uniphier.txt instead.

>  MAINTAINERS                                        |  1 +
>  2 files changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/uniphier.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/uniphier.txt b/Documentation/devicetree/bindings/arm/uniphier.txt
> new file mode 100644
> index 0000000..08d3cf3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/uniphier.txt
> @@ -0,0 +1,40 @@
> +Socionext UniPhier SoC family
> +
> +Required properties in the root node:
> +  - compatible: should contain board and SoC compatible strings
> +
> +    SoC compatibles:
> +      - "socionext,uniphier-ld4"   - LD4 SoC
> +      - "socionext,uniphier-pro4"  - Pro4 SoC
> +      - "socionext,uniphier-sld8"  - sLD8 SoC
> +      - "socionext,uniphier-pro5"  - Pro5 SoC
> +      - "socionext,uniphier-pxs2"  - PXs2 SoC
> +      - "socionext,uniphier-ld6b"  - LD6b SoC
> +      - "socionext,uniphier-ld11"  - LD11 SoC
> +      - "socionext,uniphier-ld20"  - LD20 SoC
> +      - "socionext,uniphier-pxs3"  - PXs3 SoC

Sort this? Or are these in chronological order?

> +
> +    Board compatibles:
> +      - "socionext,uniphier-ld4-ref"      - LD4 Reference Board
> +      - "socionext,uniphier-pro4-ref"     - Pro4 Reference Board
> +      - "socionext,uniphier-pro4-ace"     - Pro4 Ace Board
> +      - "socionext,uniphier-pro4-sanji"   - Pro4 Sanji Board
> +      - "socionext,uniphier-sld8-ref"     - sLD8 Reference Board
> +      - "socionext,uniphier-pxs2-gentil"  - PXs2 Gentil Board
> +      - "socionext,uniphier-pxs2-vodka"   - PXs2 Vodka Board
> +      - "socionext,uniphier-ld6b-ref"     - LD6b Reference Board
> +      - "socionext,uniphier-ld11-ref"     - LD11 Reference Board
> +      - "socionext,uniphier-ld11-global"  - LD11 Global Board
> +      - "socionext,uniphier-ld20-ref"     - LD20 Reference Board
> +      - "socionext,uniphier-ld20-global"  - LD20 Global Board
> +      - "socionext,uniphier-pxs3-ref"     - PXs3 Reference Board

I would group boards by each SoC. Then it clear which board compatibles
go with each SoC compatible and you don't have to have the SoC name in 
the board compatible.

> +
> +Example:
> +
> +/dts-v1/;
> +
> +/ {
> +	compatible = "socionext,uniphier-ld20-ref", "socionext,uniphier-ld20";
> +
> +	...
> +};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cbb89bb..1fcbd65 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2041,6 +2041,7 @@ M:	Masahiro Yamada <yamada.masahiro@socionext.com>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/arm/uniphier.txt
>  F:	Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
>  F:	arch/arm/boot/dts/uniphier*
>  F:	arch/arm/include/asm/hardware/cache-uniphier.h
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
