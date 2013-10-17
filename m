From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 17 Oct 2013 09:52:42 +0200
Subject: [PATCH] ARM: dts: mxs: add auart2 pinmux to imx28.dtsi
In-Reply-To: <1381939443-7318-1-git-send-email-aida.mynzhasova@skitlab.ru>
References: <1381939443-7318-1-git-send-email-aida.mynzhasova@skitlab.ru>
Message-ID: <20131017095242.155725b6@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Aida Mynzhasova <aida.mynzhasova@skitlab.ru> wrote:
> Add auart2 pins configuration on its main pads
> 
> Signed-off-by: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
> ---
>  arch/arm/boot/dts/imx28.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 7363fde..81102b2 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -320,6 +320,19 @@
>  					fsl,pull-up = <0>;
>  				};
>  
> +				auart2_pins_a: auart2 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						0x3080 /* MX28_PAD_AUART2_RX__AUART2_RX	*/
> +						0x3090 /* MX28_PAD_AUART2_TX__AUART2_TX */
> +						0x30a0 /* MX28_PAD_AUART2_CTS__AUART2_CTS */
> +						0x30b0 /* MX28_PAD_AUART2_RTS__AUART2_RTS */
>
Since commit 27572a2f ARM: dts: mxs: add pinctrl header files
it is no longer necessary to specify the padconfig values as numbers.
You should use the symbolic names instead.

> +					>;
> +					fsl,drive-strength = <0>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <0>;
Also these should be:
                                        fsl,drive-strength = <MXS_DRIVE_4mA>;
                                        fsl,voltage = <MXS_VOLTAGE_HIGH>;
                                        fsl,pull-up = <MXS_PULL_DISABLE>;

You probably should rebase your patch to a more recent version of
linux-next.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
