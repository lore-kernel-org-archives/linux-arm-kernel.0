From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Jul 2015 23:12:38 -0700
Subject: [PATCH V3 14/16] cpufreq: Allow drivers to enable boost support
 after registering driver
In-Reply-To: <98379f9625b9cc8ade2e052c29e86c29e11cea5e.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <98379f9625b9cc8ade2e052c29e86c29e11cea5e.1438166099.git.viresh.kumar@linaro.org>
Message-ID: <20150731061238.GN3159@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29, Viresh Kumar wrote:
> In some cases it wouldn't be known at time of driver registration, if
> the driver needs to support boost frequencies.
> 
> For example, while getting boost information from DT with opp-v2
> bindings, we need to parse the bindings for all the CPUs to know if
> turbo/boost OPPs are supported or not.
> 
> One way out to do that efficiently is to delay supporting boost mode
> (i.e. creating /sys/devices/system/cpu/cpufreq/boost file), until the
> time OPP bindings are parsed.
> 
> At that point, the driver can enable boost support. This can be done at
> ->init(), where the frequency table is created.
> 
> To do that, the driver requires few APIs from cpufreq core that let him
> do this. This patch provides these APIs.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
