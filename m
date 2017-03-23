From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 23 Mar 2017 10:04:27 +0530
Subject: [RFC 3/8] cpufreq: imx6q: Set max suspend_freq to avoid changes
 during suspend
In-Reply-To: <f2126423e233757eb113f115e0be562ea0902a7a.1490199005.git.leonard.crestez@nxp.com>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
 <f2126423e233757eb113f115e0be562ea0902a7a.1490199005.git.leonard.crestez@nxp.com>
Message-ID: <20170323043427.GE12094@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22-03-17, 18:53, Leonard Crestez wrote:
> If the cpufreq driver tries to modify voltage/freq during suspend/resume
> it might need to control an external PMIC via I2C or SPI but those
> devices might be already suspended.
> 
> To avoid this scenario we just increase cpufreq to highest setpoint
> before suspend. This issue can easily be triggered by ldo-bypass but in
> theory any regulator set_voltage call can end up having to modify
> external supply voltages.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
