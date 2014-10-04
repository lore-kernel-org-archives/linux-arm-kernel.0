From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 4 Oct 2014 21:36:18 +0200 (CEST)
Subject: [PATCH v2 5/6] ARM: dts: imx53: add cpufreq-dt support
In-Reply-To: <1411738864-26549-5-git-send-email-l.stach@pengutronix.de>
References: <1411738864-26549-1-git-send-email-l.stach@pengutronix.de>
 <1411738864-26549-5-git-send-email-l.stach@pengutronix.de>
Message-ID: <894888049.208559.1412451378291.JavaMail.open-xchange@oxbaltgw55.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,
 
i know the patch is already applied, but ...

> Lucas Stach <l.stach@pengutronix.de> hat am 26. September 2014 um 15:41
> geschrieben:
>
>
> Add all required properties for the cpufreq-dt driver.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> v2:
> - split out device instantiation
> ---
> arch/arm/boot/dts/imx53.dtsi | 13 ++++++++++++-
> 1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index c6c58c1c00e3..aa2fb2f3616d 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -46,10 +46,21 @@
> cpus {
> #address-cells = <1>;
> #size-cells = <0>;
> - cpu at 0 {
> + cpu0: cpu at 0 {
> device_type = "cpu";
> compatible = "arm,cortex-a8";
> reg = <0x0>;
> + clocks = <&clks IMX5_CLK_ARM>;
> + clock-latency = <61036>;
> + voltage-tolerance = <5>;
> + operating-points = <
> + /* kHz */
> + 166666 850000
 
shouldn't it be "166667 850000"?
 
I ran into the same issue on i.MX28. If i round down the frequencies the voltage
of the next higher OPP will be set.
 
Best regards
 
Stefan
 
> + 400000 900000
> + 800000 1050000
> + 1000000 1200000
> + 1200000 1300000
> + >;
> };
> };
>
> --
> 2.1.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
