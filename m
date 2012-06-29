From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Fri, 29 Jun 2012 11:10:19 +0800
Subject: [PATCH 2/3] ARM: imx6q: add DT node for gpmi nand
In-Reply-To: <1340941925-14591-2-git-send-email-shijie8@gmail.com>
References: <1340941925-14591-1-git-send-email-shijie8@gmail.com>
 <1340941925-14591-2-git-send-email-shijie8@gmail.com>
Message-ID: <20120629031018.GC5844@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 11:52:04PM -0400, Huang Shijie wrote:
> Add the DT node for gpmi nand.
> Add the pinmux support for gpmi nand.
> 
> The gpmi nand may conflicts with other modules, such as MMC.
> So we do not enable the gpmi nand for mx6q-arm2 board, just add the
> node for the board.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> Signed-off-by: Huang Shijie <shijie8@gmail.com>

Just one minor suggestion, see below.
Otherwise,
Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng

> ---
>  arch/arm/boot/dts/imx6q-arm2.dts |    6 ++++++
>  arch/arm/boot/dts/imx6q.dtsi     |   36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
> index bdab44c..d93a2d9 100644
> --- a/arch/arm/boot/dts/imx6q-arm2.dts
> +++ b/arch/arm/boot/dts/imx6q-arm2.dts
> @@ -22,6 +22,12 @@
>  	};
>  
>  	soc {

> +		gpmi-nand at 00112000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_gpmi_nand_1>;
> +			status = "disabled";
It would be better if we add some comment for gpmi pin conflict here.
Easy for understand.

> +		};
> +
>  		aips-bus at 02100000 { /* AIPS2 */
>  			ethernet at 02188000 {
>  				phy-mode = "rgmii";

Regards
Dong Aisheng
