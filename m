From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 19 May 2015 22:52:23 +0200
Subject: [PATCH] ARM: dts: mvebu: fix gpio misspelling in some dts files
In-Reply-To: <1432067238-4682-1-git-send-email-pbrobinson@gmail.com>
References: <1432067238-4682-1-git-send-email-pbrobinson@gmail.com>
Message-ID: <555BA287.7040904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.05.2015 22:27, Peter Robinson wrote:
> A few of the Marvell armadda/dove/kirkwood dts(i) files appear to
> have some gpio options misspelled as gpo.
>
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>   arch/arm/boot/dts/armada-370-mirabox.dts         | 2 +-
>   arch/arm/boot/dts/armada-370-netgear-rn104.dts   | 2 +-
>   arch/arm/boot/dts/armada-370-synology-ds213j.dts | 2 +-
>   arch/arm/boot/dts/dove.dtsi                      | 4 ++--

Peter,

Sorry, but NACK for dove. This is not a misspelling but the nand
pins only support GP-output hence the "gpo" function name.

Is there any verified mismatch between HW datasheet and pinctrl/DT
or did you just assume "gpo" is a misspelling?

Sebastian

[...]
> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index 9ad8295..684daa1 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -603,9 +603,9 @@
>   					marvell,function = "nand";
>   				};
>
> -				pmx_nand_gpo: pmx-nand-gpo {
> +				pmx_nand_gpio: pmx-nand-gpio {
>   					marvell,pins = "mpp_nand";
> -					marvell,function = "gpo";
> +					marvell,function = "gpio";
>   				};
>
>   				pmx_i2c1: pmx-i2c1 {
