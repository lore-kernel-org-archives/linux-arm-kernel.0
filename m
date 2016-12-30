From: stillcompiling@gmail.com (Joshua Clayton)
Date: Fri, 30 Dec 2016 09:46:13 -0800
Subject: [PATCH v3] ARM: dts: imx6: Disable "weim" node in the dtsi files
In-Reply-To: <1483092543-14233-1-git-send-email-festevam@gmail.com>
References: <1483092543-14233-1-git-send-email-festevam@gmail.com>
Message-ID: <14e3f942-13fc-7c4e-d782-26e6322cce2c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Fabio.


On 12/30/2016 02:09 AM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> Commit 1be81ea5860744520 ("ARM: dts: imx6: Add imx-weim parameters to
> dtsi's") causes the following probe error when the weim node is not
> present on the board dts (such as imx6q-sabresd):
>
> imx-weim 21b8000.weim: Invalid 'ranges' configuration
> imx-weim: probe of 21b8000.weim failed with error -22
>
> There is no need to always enable the "weim" node on mx6. Do the same
> as in the other i.MX dtsi files where "weim" is disabled and only gets
> enabled on a per dts basis.
>
> All the imx6 weim dts users explicitily provide 'status = "okay"', so
> this change has no impact on current imx6 weim users.
>
> If a board does not use the weim driver it will not describe its 'ranges'
> property, so simply disable the 'weim' node in the imx6 dtsi files to
> avoid such probe error message.
>
> Fixes: 1be81ea5860744520 ("ARM: dts: imx6: Add imx-weim parameters to dtsi's")
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> Changes since v2:
> - Fix the error message by disabling weim at dtsi level.
>
>  arch/arm/boot/dts/imx6qdl.dtsi | 1 +
>  arch/arm/boot/dts/imx6sl.dtsi  | 1 +
>  arch/arm/boot/dts/imx6sx.dtsi  | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 53e6e63..89b834f 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -1100,6 +1100,7 @@
>  				interrupts = <0 14 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clks IMX6QDL_CLK_EIM_SLOW>;
>  				fsl,weim-cs-gpr = <&gpr>;
> +				status = "disabled";
>  			};
>  
>  			ocotp: ocotp at 021bc000 {
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index 4fd6de2..19cbd87 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -900,6 +900,7 @@
>  				reg = <0x021b8000 0x4000>;
>  				interrupts = <0 14 IRQ_TYPE_LEVEL_HIGH>;
>  				fsl,weim-cs-gpr = <&gpr>;
> +				status = "disabled";
>  			};
>  
>  			ocotp: ocotp at 021bc000 {
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index 076a30f..10f3330 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -977,6 +977,7 @@
>  				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clks IMX6SX_CLK_EIM_SLOW>;
>  				fsl,weim-cs-gpr = <&gpr>;
> +				status = "disabled";
>  			};
>  
>  			ocotp: ocotp at 021bc000 {
I like this solution much better!

Joshua
