From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 23 Mar 2017 10:03:34 +0530
Subject: [RFC 2/8] cpufreq: imx6q: Fix handling EPROBE_DEFER from regulator
In-Reply-To: <7f2618363d43b30db29f5f8ae822df413392f99d.1490199005.git.leonard.crestez@nxp.com>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
 <7f2618363d43b30db29f5f8ae822df413392f99d.1490199005.git.leonard.crestez@nxp.com>
Message-ID: <20170323043334.GD12094@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22-03-17, 18:53, Leonard Crestez wrote:
> From: Irina Tirdea <irina.tirdea@nxp.com>
> 
> If there are any errors in getting the cpu0 regulators, the driver returns
> -ENOENT. In case the regulators are not yet available, the devm_regulator_get
> calls will return -EPROBE_DEFER, so that the driver can be probed later.
> If we return -ENOENT, the driver will fail its initialization and will
> not try to probe again (when the regulators become available).
> 
> Return the actual error received from regulator_get in probe. Print a
> differentiated message in case we need to probe the device later and
> in case we actually failed. Also add a message to inform when the
> driver has been successfully registered.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
