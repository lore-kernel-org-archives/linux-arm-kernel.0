From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 5 Feb 2018 08:27:44 -0200
Subject: [PATCH 1/2] arm64: dts: fsl: imx8mq: add watchdog devices
In-Reply-To: <4c7c9104ca95419d22b8df19a69819e194dd3488.1517816731.git.baruch@tkos.co.il>
References: <4c7c9104ca95419d22b8df19a69819e194dd3488.1517816731.git.baruch@tkos.co.il>
Message-ID: <CAOMZO5DgP_piWC3Q4dOs58eMJrW6XVZZ+dA583KkKLeGmWPZsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

On Mon, Feb 5, 2018 at 5:45 AM, Baruch Siach <baruch@tkos.co.il> wrote:
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 50ed302d299a..740457e2a0bf 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -250,6 +250,30 @@
>                                               "clk_ext1", "clk_ext2",
>                                               "clk_ext3", "clk_ext4";
>                         };
> +
> +                       wdog1: wdog at 30280000 {
> +                               compatible = "fsl,imx21-wdt";

Please use:

compatible = "fsl,imx8mq-wdt", "fsl,imx21-wdt"; instead.

This is the preferred way as it allows us to apply specific mx8qm
fixes if needed.

Thanks
