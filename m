From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 11 Dec 2017 14:09:05 +0530
Subject: [PATCH v4 11/12] cpufreq: Add module to register cpufreq on
 Krait CPUs
In-Reply-To: <1512726150-7204-12-git-send-email-sricharan@codeaurora.org>
References: <1512726150-7204-1-git-send-email-sricharan@codeaurora.org>
 <1512726150-7204-12-git-send-email-sricharan@codeaurora.org>
Message-ID: <20171211083905.GF25177@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08-12-17, 15:12, Sricharan R wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> Register a cpufreq-generic device whenever we detect that a
> "qcom,krait" compatible CPU is present in DT.
> 
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  .../devicetree/bindings/arm/msm/qcom,pvs.txt       |  38 ++++
>  drivers/cpufreq/Kconfig.arm                        |   9 +
>  drivers/cpufreq/Makefile                           |   1 +
>  drivers/cpufreq/qcom-cpufreq.c                     | 204 +++++++++++++++++++++
>  4 files changed, 252 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,pvs.txt
>  create mode 100644 drivers/cpufreq/qcom-cpufreq.c

This must be done differently as we have enhanced OPP core to support such
hardware. Look at: dev_pm_opp_set_prop_name() and the binding around it
(opp-microvolt-<name>). Talk to Stephen, he was part of all those discussions.

-- 
viresh
