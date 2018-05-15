From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 15 May 2018 14:49:12 +0530
Subject: [PATCH v7 12/14] cpufreq: Add Kryo CPU scaling driver
In-Reply-To: <1526375616-16904-13-git-send-email-ilialin@codeaurora.org>
References: <1526375616-16904-1-git-send-email-ilialin@codeaurora.org>
 <1526375616-16904-13-git-send-email-ilialin@codeaurora.org>
Message-ID: <20180515091912.zhc2uo7js7ukjvl7@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15-05-18, 12:13, Ilia Lin wrote:
> In Certain QCOM SoCs like apq8096 and msm8996 that have KRYO processors,
> the CPU ferequencies subset and voltage value of each OPP varies
> based on the silicon variant in use. Qualcomm Process Voltage Scaling Tables
> defines the voltage and frequency value based on the msm-id in SMEM
> and speedbin blown in the efuse combination.
> The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
> to provide the OPP framework with required information.
> This is used to determine the voltage and frequency value for each OPP of
> operating-points-v2 table when it is parsed by the OPP framework.
> 
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm          |  11 +++
>  drivers/cpufreq/Makefile             |   1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c |   3 +
>  drivers/cpufreq/qcom-cpufreq-kryo.c  | 150 +++++++++++++++++++++++++++++++++++
>  4 files changed, 165 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-kryo.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
