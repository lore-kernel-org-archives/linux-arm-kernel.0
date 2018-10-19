From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 19 Oct 2018 09:51:55 -0300
Subject: [PATCH] ARM: dts: imx6sx-sdb: Add flexcan support
In-Reply-To: <20181019094031.22492-1-qiangqing.zhang@nxp.com>
References: <20181019094031.22492-1-qiangqing.zhang@nxp.com>
Message-ID: <CAOMZO5AqZrYmc474NjvG1nF94ZNvgHyv7Q3R+QxrLmSN6EhYDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joakim,

On Fri, Oct 19, 2018 at 6:43 AM Joakim Zhang <qiangqing.zhang@nxp.com> wrote:
>
> From: Dong Aisheng <aisheng.dong@nxp.com>
>
> CAN transceiver is different on RevA and RevB board.
> It's active high on RevA while active low on Rev B.
>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sx-sdb.dts  |  5 ++++
>  arch/arm/boot/dts/imx6sx-sdb.dtsi | 42 +++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
> index 6dd9bebfe027..092b8de142a8 100644
> --- a/arch/arm/boot/dts/imx6sx-sdb.dts
> +++ b/arch/arm/boot/dts/imx6sx-sdb.dts
> @@ -10,6 +10,11 @@
>
>  / {
>         model = "Freescale i.MX6 SoloX SDB RevB Board";
> +
> +       /* Transceiver EN/STBY is active low on RevB board */
> +       reg_can_stby: regulator-can-stby {
> +               gpio = <&gpio4 27 GPIO_ACTIVE_LOW>;

Don't we need a  gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>; and also a
"enable-active-high" entries in the imx6sx-sdb-reva.dts?
