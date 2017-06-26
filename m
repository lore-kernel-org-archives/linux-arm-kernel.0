From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 26 Jun 2017 19:15:24 +0200
Subject: [PATCH v3 2/3] dt-bindings: input: Add R_LRADC support for A83T
In-Reply-To: <20170624024515.4669-3-techping.chan@gmail.com>
References: <20170624024515.4669-1-techping.chan@gmail.com>
 <20170624024515.4669-3-techping.chan@gmail.com>
Message-ID: <20170626171524.cqfyasetpsfr6xfg@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jun 24, 2017 at 10:45:14AM +0800, Ziping Chen wrote:
> From: Ziping Chen <techping.chan@gmail.com>
> 
> Allwinner A83T SoC has a low res adc like the one
> in Allwinner A10 SoC.
> 
> Add binding for it.
> 
> Signed-off-by: Ziping Chen <techping.chan@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt b/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
> index 4357e498ef04..525d85e3043f 100644
> --- a/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
> +++ b/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
> @@ -2,12 +2,14 @@ Allwinner sun4i low res adc attached tablet keys
>  ------------------------------------------------
>  
>  Required properties:
> - - compatible: "allwinner,sun4i-a10-lradc-keys"
> + - compatible: should be one of the following string:
> +		"allwinner,sun4i-a10-lradc-keys"
> +		"allwinner,sun8i-a83t-r-lradc-keys"

This doesn't really have anything related to keys, and can be used
purely as an ADC.

I know this is the compatible that was used for the A10, but I'd
rather drop the keys for the the new compatible.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170626/6c5d9364/attachment.sig>
