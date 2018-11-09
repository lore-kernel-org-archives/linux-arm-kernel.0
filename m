From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 09 Nov 2018 16:01:03 +0100
Subject: [PATCH 3/4] dt-bindings: reset: uniphier: Add AHCI core reset
 description
In-Reply-To: <1541727727-10821-4-git-send-email-hayashi.kunihiko@socionext.com>
References: <1541727727-10821-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1541727727-10821-4-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1541775663.4112.48.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kunihiko,

On Fri, 2018-11-09 at 10:42 +0900, Kunihiko Hayashi wrote:
> Add compatible strings for reset control of AHCI core implemented in
> UniPhier SoCs. The reset control belongs to AHCI glue layer.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  Documentation/devicetree/bindings/reset/uniphier-reset.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> index f63c511..ea00517 100644
> --- a/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> +++ b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> @@ -133,6 +133,9 @@ Required properties:
>      "socionext,uniphier-pxs2-usb3-reset" - for PXs2 SoC USB3
>      "socionext,uniphier-ld20-usb3-reset" - for LD20 SoC USB3
>      "socionext,uniphier-pxs3-usb3-reset" - for PXs3 SoC USB3
> +    "socionext,uniphier-pro4-ahci-reset" - for Pro4 SoC AHCI
> +    "socionext,uniphier-pxs2-ahci-reset" - for PXs2 SoC AHCI
> +    "socionext,uniphier-pxs3-ahci-reset" - for PXs3 SoC AHCI

Since the driver behaves identically for "socionext,uniphier-pro4-usb3-
reset" and "socionext,uniphier-pro4-ahci-reset", would it make sense to
add a common compatible?
Something like:
"socionext,uniphier-pro4-usb3-reset", "socionext,uniphier-pro4-glue-reset" - for USB3 SoC AHCI
"socionext,uniphier-pro4-ahci-reset", "socionext,uniphier-pro4-glue-reset" - for Pro4 SoC AHCI

That way if more places turn up where the glue layer reset is used,
you can add them without patching the driver every time.

regards
Philipp
