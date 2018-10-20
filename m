From: qiangqing.zhang@nxp.com (Joakim Zhang)
Date: Sat, 20 Oct 2018 02:03:34 +0000
Subject: [PATCH] ARM: dts: imx6sx-sdb: Add flexcan support
In-Reply-To: <CAOMZO5AqZrYmc474NjvG1nF94ZNvgHyv7Q3R+QxrLmSN6EhYDw@mail.gmail.com>
References: <20181019094031.22492-1-qiangqing.zhang@nxp.com>
 <CAOMZO5AqZrYmc474NjvG1nF94ZNvgHyv7Q3R+QxrLmSN6EhYDw@mail.gmail.com>
Message-ID: <DB7PR04MB46185B34429D52D0D5F7465CE6FA0@DB7PR04MB4618.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


-----Original Message-----
From: Fabio Estevam [mailto:festevam at gmail.com] 
Sent: 2018?10?19? 20:52
To: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>; Sascha Hauer <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; dl-linux-imx <linux-imx@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; A.s. Dong <aisheng.dong@nxp.com>; open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linux-kernel <linux-kernel@vger.kernel.org>; moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Add flexcan support

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
> arch/arm/boot/dts/imx6sx-sdb.dtsi | 42 +++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts 
> b/arch/arm/boot/dts/imx6sx-sdb.dts
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

Don't we need a  gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>; and also a "enable-active-high" entries in the imx6sx-sdb-reva.dts?

Yes, you are right. I will add the entry in the imx6sx-sdb-reva.dts. Thanks a lot! 

BRs,
Jaokim Zhang
