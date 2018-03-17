From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 17 Mar 2018 11:53:08 -0300
Subject: [PATCH 1/2] ARM: dts: pfuze3000: update sw1a/vldo4 voltage range
In-Reply-To: <1521269828-8874-1-git-send-email-Anson.Huang@nxp.com>
References: <1521269828-8874-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5BzE46Dm24++j+xVA4KGFnpsopGfJ97h7sFGOAxVa19=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Sat, Mar 17, 2018 at 3:57 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> Update sw1a/vldo4's voltage range according to latest pfuze3000
> datasheet from:
>
> http://cache.freescale.com/files/analog/doc/data_sheet/PF3000.pdf?fsrch=1&sr=1&pageNum=1
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sx-udoo-neo.dtsi  | 2 +-
>  arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 4 ++--
>  arch/arm/boot/dts/imx7d-nitrogen7.dts   | 2 +-
>  arch/arm/boot/dts/imx7d-sdb.dts         | 6 +++---
>  arch/arm/boot/dts/imx7s-warp.dts        | 2 +-
>  5 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
> index 53b3eac..1de0a0f 100644
> --- a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
> +++ b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
> @@ -142,7 +142,7 @@
>                 regulators {
>                         sw1a_reg: sw1a {
>                                 regulator-min-microvolt = <700000>;
> -                               regulator-max-microvolt = <1475000>;
> +                               regulator-max-microvolt = <3300000>;

This change does not look like a safe thing to do without carefully
checking each one of the board schematics.

Even if the regulator itself is capable of driving a higher voltage,
it does not mean that the circuitry that consumes such regulator is
allowed to receive the higher voltages.
