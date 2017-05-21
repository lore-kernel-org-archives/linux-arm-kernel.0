From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 21 May 2017 16:54:01 +0200
Subject: [PATCH 1/1] dt-binding: net: wireless: fix node name in the
 BCM43xx example
In-Reply-To: <20170515201356.26384-2-martin.blumenstingl@googlemail.com>
References: <20170515201356.26384-1-martin.blumenstingl@googlemail.com>
 <20170515201356.26384-2-martin.blumenstingl@googlemail.com>
Message-ID: <e0b336e6-538e-eeea-0ed4-33460dbef7e0@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 15.05.2017 um 22:13 schrieb Martin Blumenstingl:
> The example in the BCM43xx documentation uses "brcmf" as node name.

No, it doesn't, it uses "bcrmf".

This typo has spread to all ARM device trees:

$ git grep bcrmf -- arch/arm/boot/dts/
arch/arm/boot/dts/imx6sx-nitrogen6sx.dts:       brcmf: bcrmf at 1 {
arch/arm/boot/dts/imx6ul-opos6ul.dtsi:  brcmf: bcrmf at 1 {
arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts:       brcmf: bcrmf at 1 {
arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts:       brcmf: bcrmf at 1 {
arch/arm/boot/dts/sun7i-a20-bananapro.dts:      brcmf: bcrmf at 1 {
arch/arm/boot/dts/sun7i-a20-cubietruck.dts:     brcmf: bcrmf at 1 {
arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts:      brcmf: bcrmf at 1 {
arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts:       brcmf: bcrmf at 1 {
arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts:        brcmf: bcrmf at 1 {

For arch/arm64/boot/dts/amlogic/* I've already fixed it, originally by
changing to "brcmf", in a second step "wifi" was requested.

> However, wireless devices should be named "wifi" instead. Fix this to
> make sure that .dts authors can simply use the documentation as
> reference (or simply copy the node from the documentation and then
> adjust only the board specific bits).
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt b/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
> index 5dbf169cd81c..590f622188de 100644
> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
> @@ -31,7 +31,7 @@ mmc3: mmc at 01c12000 {
>  	non-removable;
>  	status = "okay";
>  
> -	brcmf: bcrmf at 1 {
> +	brcmf: wifi at 1 {
>  		reg = <1>;
>  		compatible = "brcm,bcm4329-fmac";
>  		interrupt-parent = <&pio>;

Thanks for fixing this at its source.

Hopefully the maintainers in CC can make sure that at least it doesn't
spread further into new DTs.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
