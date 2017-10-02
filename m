From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 2 Oct 2017 22:42:35 +0200
Subject: [PATCH v3 12/12] ARM: dtsi: axp81x: set pinmux for GPIO0/1 when
 used as LDOs
In-Reply-To: <20171002120854.5212-13-quentin.schulz@free-electrons.com>
References: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
 <20171002120854.5212-13-quentin.schulz@free-electrons.com>
Message-ID: <20171002204235.25d4437a2p5qzrrj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 02, 2017 at 12:08:54PM +0000, Quentin Schulz wrote:
> On AXP813/818, GPIO0 and GPIO1 can be used as LDO as (respectively)
> ldo_io0 and ldo_io1.
> 
> Let's add the pinctrl properties to the said regulators.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  arch/arm/boot/dts/axp81x.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
> index f90f257130d5..099b0ddc1bbb 100644
> --- a/arch/arm/boot/dts/axp81x.dtsi
> +++ b/arch/arm/boot/dts/axp81x.dtsi
> @@ -52,6 +52,16 @@
>  		compatible = "x-powers,axp813-gpio";
>  		gpio-controller;
>  		#gpio-cells = <2>;
> +
> +		gpio0_ldo: gpio0_ldo {
> +			pins = "GPIO0";
> +			function = "ldo";
> +		};
> +
> +		gpio1_ldo: gpio1_ldo {
> +			pins = "GPIO1";
> +			function = "ldo";
> +		};

The node names are not supposed to contain any hyphens.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171002/9bc56e2b/attachment.sig>
