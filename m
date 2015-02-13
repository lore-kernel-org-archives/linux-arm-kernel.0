From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 13 Feb 2015 15:53:58 +0100
Subject: [PATCH 4/5] ARM: dts: imx28-apf28dev: add support for can0
In-Reply-To: <1423836725-86061-4-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1423836725-86061-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <1423836725-86061-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <1423836725-86061-3-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <1423836725-86061-4-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20150213155358.12678942@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Gwenhael Goavec-Merou wrote:
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> Signed-off-by: Sebastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
>  arch/arm/boot/dts/imx28-apf28dev.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
> index 68405c3..a052d3e 100644
> --- a/arch/arm/boot/dts/imx28-apf28dev.dts
> +++ b/arch/arm/boot/dts/imx28-apf28dev.dts
> @@ -110,6 +110,13 @@
>  					};
>  				};
>  			};
> +
> +			can0: can at 80032000 {
>
Did you compile-test this? It should produce a build error, since
the label can0 already exists in imx28.dtsi.
You should use:
|&can0 {
|				pinctrl-names = "default";
|				pinctrl-0 = <&can0_pins_a>;
|				xceiver-supply = <&reg_can0_vcc>;
|				status = "okay";
|};

> @@ -176,6 +183,14 @@
>  			gpio = <&gpio1 23 1>;
s/ 1/ GPIO_ACTIVE_LOW/ ?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
