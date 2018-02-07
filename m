From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Wed, 7 Feb 2018 15:30:47 +0530
Subject: [PATCH 3/4] arm64: dts: qcom: msm8916: Add clock properties to
 the APCS node
In-Reply-To: <20180205144651.5934-3-georgi.djakov@linaro.org>
References: <20180205144651.5934-1-georgi.djakov@linaro.org>
 <20180205144651.5934-3-georgi.djakov@linaro.org>
Message-ID: <CAHLCerOSx+vMMHYj-1cCE8PPGFm=_523Qxeg__AzSjYbtA2FiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 5, 2018 at 8:16 PM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
> There are clock controller registers in the APCS block, which purpose

If you respin this, s/which/whose

> is to control the main CPU mux and divider. Add the clock properties as
> part of the APCS device-tree node.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 5414f53a0fa1..4539571a36b2 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -336,6 +336,8 @@
>                         compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
>                         reg = <0xb011000 0x1000>;
>                         #mbox-cells = <1>;
> +                       clocks = <&a53pll>;
> +                       #clock-cells = <0>;
>                 };
>
>                 blsp1_uart2: serial at 78b0000 {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
