From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 24 Apr 2012 14:46:34 +0200
Subject: [PATCH v2 3/3] ARM: imx6q: switch to use pinctrl driver
In-Reply-To: <1334933916-12971-3-git-send-email-b29396@freescale.com>
References: <1334933916-12971-1-git-send-email-b29396@freescale.com>
 <1334933916-12971-3-git-send-email-b29396@freescale.com>
Message-ID: <20120424124634.GH9142@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22:58 Fri 20 Apr     , Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> 
> ---
> This is not a formal patch and is only used for test
> since before the pinctrl core handle dummy state is in,
> enable pinctrl in driver will break other platforms.
> 
> ChangeLog v1->v2:
> * using updated binding
> ---
>  arch/arm/boot/dts/imx6q-arm2.dts   |    2 ++
>  arch/arm/boot/dts/imx6q.dtsi       |   17 +++++++++++++++++
>  arch/arm/mach-imx/Kconfig          |    2 ++
>  drivers/mmc/host/sdhci-esdhc-imx.c |   12 ++++++++++++
>  4 files changed, 33 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
> index ce1c823..68b1d8d 100644
> --- a/arch/arm/boot/dts/imx6q-arm2.dts
> +++ b/arch/arm/boot/dts/imx6q-arm2.dts
> @@ -44,6 +44,8 @@
>  				fsl,card-wired;
>  				vmmc-supply = <&reg_3p3v>;
>  				status = "okay";
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_usdhc4_1>;
>  			};
>  
>  			uart4: uart at 021f0000 {
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index 4905f51..8cbd88b 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -386,7 +386,24 @@
>  			};
>  
>  			iomuxc at 020e0000 {
> +				compatible = "fsl,imx6q-iomuxc";
>  				reg = <0x020e0000 0x4000>;
> +
> +				/* shared pinctrl settings */
> +				usdhc4 {
> +					pinctrl_usdhc4_1: usdhc4grp-1 {
> +						fsl,pins = <1386 0x17059	/* MX6Q_PAD_SD4_CMD__USDHC4_CMD */
> +							    1392 0x17059	/* MX6Q_PAD_SD4_CLK__USDHC4_CLK	*/
> +							    1462 0x17059	/* MX6Q_PAD_SD4_DAT0__USDHC4_DAT0 */
> +							    1470 0x17059	/* MX6Q_PAD_SD4_DAT1__USDHC4_DAT1 */
> +							    1478 0x17059	/* MX6Q_PAD_SD4_DAT2__USDHC4_DAT2 */
> +							    1486 0x17059	/* MX6Q_PAD_SD4_DAT3__USDHC4_DAT3 */
> +							    1493 0x17059	/* MX6Q_PAD_SD4_DAT4__USDHC4_DAT4 */
> +							    1501 0x17059	/* MX6Q_PAD_SD4_DAT5__USDHC4_DAT5 */
> +							    1509 0x17059	/* MX6Q_PAD_SD4_DAT6__USDHC4_DAT6 */
> +							    1517 0x17059>;	/* MX6Q_PAD_SD4_DAT7__USDHC4_DAT7 */
Can you on IMX have alternative onfiguration where you use as example just one
pin on a different pad?

Best Regards,
J.
