From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 27 Aug 2013 17:27:57 +0200
Subject: [PATCH 2/2] Add sunxi-sid to dts for sun4i, sun5i and sun7i
In-Reply-To: <1377612785-7868-3-git-send-email-oliver+list@schinagl.nl>
References: <1377612785-7868-1-git-send-email-oliver+list@schinagl.nl>
 <1377612785-7868-3-git-send-email-oliver+list@schinagl.nl>
Message-ID: <20130827152757.GK2695@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oliver,

Please prefix your patch with "ARM: sunxi: dt:"

On Tue, Aug 27, 2013 at 04:13:05PM +0200, oliver+list at schinagl.nl wrote:
> From: Oliver Schinagl <oliver@schinagl.nl>
> 
> This patch shall add support for the sunxi-sid driver to the device
> table for sun4i, sun5i and sun7i.
  ^ tree    ^ A10, A13 and A20
> 
> Signed-off-by: Oliver Schinagl <oliver@schinagl.nl>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 5 +++++
>  arch/arm/boot/dts/sun5i-a13.dtsi | 5 +++++
>  arch/arm/boot/dts/sun7i-a20.dtsi | 6 ++++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index b2bd6e1..179e024 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -267,6 +267,11 @@
>  			reg = <0x01c20c90 0x10>;
>  		};
>  
> +		sid: eeprom at 01c23800 {
> +			compatible = "allwinner,sun4i-sid";
> +			reg = <0x01c23800 0x10>;
> +		};
> +
>  		uart0: serial at 01c28000 {
>  			compatible = "snps,dw-apb-uart";
>  			reg = <0x01c28000 0x400>;
> diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
> index 7363211..999fdb3 100644
> --- a/arch/arm/boot/dts/sun5i-a13.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a13.dtsi
> @@ -223,6 +223,11 @@
>  			reg = <0x01c20c90 0x10>;
>  		};
>  
> +		sid: eeprom at 01c23800 {
> +			compatible = "allwinner,sun4i-sid";
> +			reg = <0x01c23800 0x10>;
> +		};
> +
>  		uart1: serial at 01c28400 {
>  			compatible = "snps,dw-apb-uart";
>  			reg = <0x01c28400 0x400>;
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index fb81e78..bcf32b4 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -217,6 +217,12 @@
>  			reg = <0x01c20c90 0x10>;
>  		};
>  
> +		sid: eeprom at 01c23800 {
> +			compatible = "allwinner,sun7i-sid";

I'd prefer to have sun7i-a20-sid here. We usually mention the soc name
as well in the compatible when it's not the good ol' A10.

> +			reg = <0x01c23800 0x200>;
> +		};
> +
> +

Drop the extra line

Thanks,
Maxime

>  		uart0: serial at 01c28000 {
>  			compatible = "snps,dw-apb-uart";
>  			reg = <0x01c28000 0x400>;
> -- 
> 1.8.1.5
> 

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130827/b7144d41/attachment.sig>
