From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 12 Jul 2017 12:48:02 +0530
Subject: [RFC v2 4/6] drivers: boot_constraint: Add debugfs support
In-Reply-To: <c52f57d42ec875da97acde84e5dbe86be5390f6c.1499770771.git.viresh.kumar@linaro.org>
References: <cover.1499770771.git.viresh.kumar@linaro.org>
 <c52f57d42ec875da97acde84e5dbe86be5390f6c.1499770771.git.viresh.kumar@linaro.org>
Message-ID: <20170712071802.GA1679@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-07-17, 12:04, Viresh Kumar wrote:
> This patch adds debugfs support for boot constraints. This is how it
> looks for a "vmmc-supply" constraint for the MMC device.
> 
> $ ls -R /sys/kernel/debug/boot_constraints/
> /sys/kernel/debug/boot_constraints/:
> f723d000.dwmmc0
> 
> /sys/kernel/debug/boot_constraints/f723d000.dwmmc0:
> supply-vmmc
> 
> /sys/kernel/debug/boot_constraints/f723d000.dwmmc0/supply-vmmc:
> u_volt_max  u_volt_min
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/boot_constraint.c | 80 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)

Forgot to mention that this one depends on
https://marc.info/?l=linux-kernel&m=149870936319587 for compilation
without CONFIG_DEBUG_FS.

--
viresh
