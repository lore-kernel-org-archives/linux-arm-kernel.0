From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Tue, 25 Aug 2015 10:10:44 +0800
Subject: [RESEND PATCH 0/3 v6] Add Mediatek MT8173 cpufreq driver
In-Reply-To: <1439803465-19683-1-git-send-email-pi-cheng.chen@linaro.org>
References: <1439803465-19683-1-git-send-email-pi-cheng.chen@linaro.org>
Message-ID: <CALx668VWg2xVxzy8P7f5QFWRzm+TDJXUghL-_rbvRLsLYjtnng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 17, 2015 at 5:24 PM, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
> MT8173 is a ARMv8 based SoC with 2 clusters. All CPUs in a single cluster
> share the same power and clock domain. This series tries to add cpufreq support
> for MT8173 SoC. The v6 of this series is resent with Acks added.

Hi Rafael,

Not sure if I has missed the merge window.
Do I have chance to have this series merged for 4.3?
Would you please take [1,2] of this series?
Thanks.

Best Regards,
Pi-Cheng

>
> changes in v6:
> - Move clock and regulator consumer properties document to the device tree
>   bindings documents of MT8173 CPU DVFS clock driver
> - Add change log to describe what is implemented in the MT8173 cpufreq driver
> - Add missed rcu_read_unlock() in the error path
> - Move of_init_opp_table() call to make sure all required hardware resources
>   are already there before it is called
> - Add comments to describe why both platform driver and deivce registration
>   codes are put in the initcall function
> - Use the term "voltage tracking" instead of "voltage trace" according to an
>   internal SoC document
>
> changes in v5:
> - Move resource allocation code from init() into probe() and remove some unused
>   functions due to this change
> - Fix descriptions for device tree binding document
> - Address review comments for last version
> - Register CPU cooling device
>
> Changes in v4:
> - Add bindings for MT8173 cpufreq driver
> - Move OPP table back into device tree
> - Address comments for last version
>
> Changes in v3:
> - Implement MT8173 specific standalone cpufreq driver instead of using
>   cpufreq-dt driver
> - Define OPP table in the driver source code until new OPP binding is ready
>
> Changes in v2:
> - Add intermediate frequency support in cpufreq-dt driver
> - Use voltage scaling code of cpufreq-dt for little cluster instead of
>   implementaion in notifier of mtk-cpufreq driver
> - Code refinement for mtk-cpufreq driver
>
> Pi-Cheng Chen (3):
>   dt-bindings: mediatek: Add MT8173 CPU DVFS clock bindings
>   cpufreq: mediatek: Add MT8173 cpufreq driver
>   arm64: dts: mt8173: Add mt8173 cpufreq driver support
>
>  .../devicetree/bindings/clock/mt8173-cpu-dvfs.txt  |  83 ++++
>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |  18 +
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  64 +++
>  drivers/cpufreq/Kconfig.arm                        |   7 +
>  drivers/cpufreq/Makefile                           |   1 +
>  drivers/cpufreq/mt8173-cpufreq.c                   | 524 +++++++++++++++++++++
>  6 files changed, 697 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt
>  create mode 100644 drivers/cpufreq/mt8173-cpufreq.c
>
> --
> 1.9.1
>
