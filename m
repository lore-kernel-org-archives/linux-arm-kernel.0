From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 4 Mar 2015 15:59:39 +0530
Subject: [PATCH v2 2/4] cpufreq: dt-bindings: add bindings for mtk-cpufreq
 driver
In-Reply-To: <1425458956-20665-3-git-send-email-pi-cheng.chen@linaro.org>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
 <1425458956-20665-3-git-send-email-pi-cheng.chen@linaro.org>
Message-ID: <CAKohpomxTVBkj=EzucUE7BvV6LVCs6r+S4FE_UvUofgogZWtdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 March 2015 at 14:19, pi-cheng.chen <pi-cheng.chen@linaro.org> wrote:
> Add dt-binding for mtk-cpufreq driver so that the driver could get SoC specific
> information (intermediate_clk for now) from device tree.
>
> Signed-off-by: pi-cheng.chen <pi-cheng.chen@linaro.org>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-mtk.txt         | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mtk.txt
>
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mtk.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mtk.txt
> new file mode 100644
> index 0000000..53bf108
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mtk.txt
> @@ -0,0 +1,17 @@
> +
> +Mediatek cpufreq driver
> +-------------------
> +
> +Mediatek SoC cpufreq driver for CPU frequency scaling.
> +
> +Required properties:
> +- compatible: "mediatek,mtk-cpufreq"
> +- intermediate_clk: The intermediate clock source which CPUs will switch to
> +during CPU frequency transition.
> +
> +Examples:
> +--------
> +       mtk-cpufreq {
> +               compatible = "mediatek,mtk-cpufreq";
> +               intermediate_clk = <&apmixedsys APMIXED_MAINPLL>;
> +       };

Such nodes aren't allowed. NACK.
