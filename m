From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 19 Aug 2015 11:11:20 +0530
Subject: [PATCH v7 2/3] cpufreq: mediatek: Add MT8173 cpufreq driver
In-Reply-To: <1439949906-22177-1-git-send-email-pi-cheng.chen@linaro.org>
References: <20150818102428.GD31148@linux>
 <1439949906-22177-1-git-send-email-pi-cheng.chen@linaro.org>
Message-ID: <20150819054120.GA3258@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19-08-15, 10:05, Pi-Cheng Chen wrote:
> Mediatek MT8173 is an ARMv8 based quad-core (2*Cortex-A53 and
> 2*Cortex-A72) SoC with duall clusters. For each cluster, two voltage
> inputs, Vproc and Vsram are supplied by two regulators. For the big
> cluster, two regulators come from different PMICs. In this case, when
> scaling voltage inputs of the cluster, the voltages of two regulator
> inputs need to be controlled by software explicitly under the SoC
> specific limitation:
> 
> 	100mV < Vsram - Vproc < 200mV
> 
> which is called 'voltage tracking' mechanism. And when scaling the
> frequency of cluster clock input, the input MUX need to be parented to
> another "intermediate" stable PLL first and reparented to the original
> PLL once the original PLL is stable at the target frequency. This patch
> implements those mechanisms to enable CPU DVFS support for Mediatek
> MT8173 SoC.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> 
> Changes in v7:
> - add of_machine_is_compatible() check to be multiplatform friendly

Looks fine, thanks.

-- 
viresh
