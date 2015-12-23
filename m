From: bhupesh.linux@gmail.com (Bhupesh SHARMA)
Date: Wed, 23 Dec 2015 10:53:04 +0530
Subject: [PATCH v3 2/2] dts/ls2080a: Update DTSI to add support of SP805
 WDT
In-Reply-To: <1450189825-29065-3-git-send-email-bhupesh.sharma@freescale.com>
References: <1450189825-29065-1-git-send-email-bhupesh.sharma@freescale.com>
 <1450189825-29065-3-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <CAFTCetS7P6wF3MhgMSXSXP_jnLQvBc-NSY0TW3OOnCjtbL0N_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin

On Tue, Dec 15, 2015 at 8:00 PM, Bhupesh Sharma
<bhupesh.sharma@freescale.com> wrote:
> This patch updates the LS2080a DTSI (DTS Include) file to add
> support for eight SP805 Watchdog units which can be used to
> reset the eight Cortex-A57 cores available on LS2080A.
>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi |   56 ++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)

Since Rob has acked the SP805 WDT binding documentation patch (patch
1/2 of this series),
can this DTSI change, please be considered for absorption in the arm-soc tree.

Regards,
Bhupesh

>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> index e81cd48..7b0f411 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> @@ -193,6 +193,62 @@
>                         interrupts = <0 32 0x4>; /* Level high type */
>                 };
>
> +               cluster1_core0_watchdog: wdt at c000000 {
> +                       compatible = "arm,sp805-wdt", "arm,primecell";
> +                       reg = <0x0 0xc000000 0x0 0x1000>;
> +                       clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +                       clock-names = "apb_pclk", "wdog_clk";
> +               };
> +
> +               cluster1_core1_watchdog: wdt at c010000 {
> +                       compatible = "arm,sp805-wdt", "arm,primecell";
> +                       reg = <0x0 0xc010000 0x0 0x1000>;
> +                       clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +                       clock-names = "apb_pclk", "wdog_clk";
> +               };
> +
> +               cluster2_core0_watchdog: wdt at c100000 {
> +                       compatible = "arm,sp805-wdt", "arm,primecell";
> +                       reg = <0x0 0xc100000 0x0 0x1000>;
> +                       clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +                       clock-names = "apb_pclk", "wdog_clk";
> +               };
> +
> +               cluster2_core1_watchdog: wdt at c110000 {
> +                       compatible = "arm,sp805-wdt", "arm,primecell";
> +                       reg = <0x0 0xc110000 0x0 0x1000>;
> +                       clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +                       clock-names = "apb_pclk", "wdog_clk";
> +               };
> +
> +               cluster3_core0_watchdog: wdt at c200000 {
> +                       compatible = "arm,sp805-wdt", "arm,primecell";
> +                       reg = <0x0 0xc200000 0x0 0x1000>;
> +                       clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +                       clock-names = "apb_pclk", "wdog_clk";
> +               };
> +
> +               cluster3_core1_watchdog: wdt at c210000 {
> +                       compatible = "arm,sp805-wdt", "arm,primecell";
> +                       reg = <0x0 0xc210000 0x0 0x1000>;
> +                       clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +                       clock-names = "apb_pclk", "wdog_clk";
> +               };
> +
> +               cluster4_core0_watchdog: wdt at c300000 {
> +                       compatible = "arm,sp805-wdt", "arm,primecell";
> +                       reg = <0x0 0xc300000 0x0 0x1000>;
> +                       clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +                       clock-names = "apb_pclk", "wdog_clk";
> +               };
> +
> +               cluster4_core1_watchdog: wdt at c310000 {
> +                       compatible = "arm,sp805-wdt", "arm,primecell";
> +                       reg = <0x0 0xc310000 0x0 0x1000>;
> +                       clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +                       clock-names = "apb_pclk", "wdog_clk";
> +               };
> +
>                 fsl_mc: fsl-mc at 80c000000 {
>                         compatible = "fsl,qoriq-mc";
>                         reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
> --
> 1.7.9.5
>
>
