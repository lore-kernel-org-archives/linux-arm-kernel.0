From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 2 Mar 2015 11:46:54 +0530
Subject: [PATCH 2/2] dt-bindings: cpufreq: document for hisilicon acpu
 driver
In-Reply-To: <1424956899-8891-3-git-send-email-leo.yan@linaro.org>
References: <1424956899-8891-1-git-send-email-leo.yan@linaro.org>
 <1424956899-8891-3-git-send-email-leo.yan@linaro.org>
Message-ID: <CAKohpokXT3m0jnX4R25gzcJUAf_HFj15MueOD2mhG6DRF-0uvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For bindings you need to cc DT list, cc'd now..

On 26 February 2015 at 18:51, Leo Yan <leo.yan@linaro.org> wrote:
> This adds documentation for hisilicon acpu's cpufreq driver.
>
> OPP library is used for device tree parsing to get frequency list;
> Furthermore, this driver can bind all CPUs to change frequency together,
> or the two clusters can trigger the frequency change independently. This
> is controlled by the dtb flag "hisilicon,coupled-clusters".
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  .../bindings/cpufreq/cpufreq-hisi-acpu.txt         | 112 +++++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-hisi-acpu.txt

Bindings must be added before using them and so this patch should have been 1/2.
Apart from that, it looks like you can reuse cpufreq-dt easily without
much trouble.


> +- hisilicon,coupled-clusters: Specify whether all clusters share one clock
> +       source. This must be defined under node cpufreq.

> +cpufreq {
> +       compatible = "hisilicon,hisi-acpu-cpufreq";
> +       hisilicon,coupled-clusters = <1>;
> +};

Such virtual nodes aren't allowed in DT.
