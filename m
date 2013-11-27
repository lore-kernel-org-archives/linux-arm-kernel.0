From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 27 Nov 2013 14:08:29 +0100
Subject: [PATCH] ARM: DT: imx6qdl: fix can clocks
In-Reply-To: <1385558060-20314-1-git-send-email-list-09_linux_arm@tqsc.de>
References: <1385558060-20314-1-git-send-email-list-09_linux_arm@tqsc.de>
Message-ID: <1385557709.4272.1.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 27.11.2013, 14:14 +0100 schrieb Markus Niebel:
> From: Markus Niebel <Markus.Niebel@tqs.de>
> 
> per and ipg clock numbers are exchanged. This leads to
> wrong bitrate calculation.
> 
NACK

According to the clock driver clock numbers are IPG->PER.
I think this is the same problem we encountered on i.MX5 and is fixed
with commit "can: flexcan: use correct clock as base for bit rate
calculation"

> Signed-off-by: Markus Niebel <Markus.Niebel@tqs.de>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 59154dc..797f007 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -329,7 +329,7 @@
>  				compatible = "fsl,imx6q-flexcan";
>  				reg = <0x02090000 0x4000>;
>  				interrupts = <0 110 0x04>;
> -				clocks = <&clks 108>, <&clks 109>;
> +				clocks = <&clks 109>, <&clks 108>;
>  				clock-names = "ipg", "per";
>  			};
>  
> @@ -337,7 +337,7 @@
>  				compatible = "fsl,imx6q-flexcan";
>  				reg = <0x02094000 0x4000>;
>  				interrupts = <0 111 0x04>;
> -				clocks = <&clks 110>, <&clks 111>;
> +				clocks = <&clks 111>, <&clks 110>;
>  				clock-names = "ipg", "per";
>  			};
>  

-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
