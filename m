From: swboyd@chromium.org (Stephen Boyd)
Date: Fri, 13 Jul 2018 09:00:19 -0700
Subject: [PATCH v3 1/2] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
In-Reply-To: <20180709212522.187257-1-mka@chromium.org>
References: <20180709212522.187257-1-mka@chromium.org>
Message-ID: <153149761947.48062.16210609862063613310@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Matthias Kaehlcke (2018-07-09 14:25:21)
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> index 92bed1e7d4bb..7eea94701b23 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -11,6 +11,13 @@
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>  
> +               pm8998_temp: temp-alarm at 2400 {

Are we sorting this file based on node name or unit address? Otherwise
patch looks good.

> +                       compatible = "qcom,spmi-temp-alarm";
> +                       reg = <0x2400>;
> +                       interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
> +                       #thermal-sensor-cells = <0>;
> +               };
> +
>                 pm8998_gpio: gpios at c000 {
>                         compatible = "qcom,pm8998-gpio", "qcom,spmi-gpio";
>                         reg = <0xc000>;
