From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 8 Mar 2015 18:25:01 +0100
Subject: [PATCH 6/7] ARM: dts: sun7i: Add OOB irq support to boards with
 broadcom sdio wifi
In-Reply-To: <1425754884-7875-6-git-send-email-hdegoede@redhat.com>
References: <1425754884-7875-1-git-send-email-hdegoede@redhat.com>
 <1425754884-7875-6-git-send-email-hdegoede@redhat.com>
Message-ID: <20150308172501.GG5085@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 07, 2015 at 08:01:23PM +0100, Hans de Goede wrote:
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 11 +++++++++++
>  arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts  | 11 +++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> index 0c219a4..8111b0c 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> @@ -167,12 +167,23 @@
>  };
>  
>  &mmc3 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +

Aside from Chen-Yu's comments, that should be in the DTSI.

>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc3_pins_a>;
>  	vmmc-supply = <&reg_vmmc3>;
>  	bus-width = <4>;
>  	non-removable;
>  	status = "okay";
> +
> +	brcmf: bcrmf at 1 {
> +		reg = <1>;
> +		compatible = "brcm,bcm4329-fmac";
> +		interrupt-parent = <&pio>;
> +		interrupts = <10 8>; /* PH10 / EINT10 */

And you can use interrupts-extented here (not that I really care much,
both solutions works for me).

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150308/2fc0ca41/attachment-0001.sig>
