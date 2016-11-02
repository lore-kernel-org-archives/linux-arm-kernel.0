From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 2 Nov 2016 09:33:11 +0530
Subject: [PATCH v3 3/3] cpufreq: ti: Add cpufreq driver to determine
 available OPPs at runtime
In-Reply-To: <20161027214131.1725-4-d-gerlach@ti.com>
References: <20161027214131.1725-1-d-gerlach@ti.com>
 <20161027214131.1725-4-d-gerlach@ti.com>
Message-ID: <20161102040311.GB10786@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27-10-16, 16:41, Dave Gerlach wrote:
> Some TI SoCs, like those in the AM335x, AM437x, DRA7x, and AM57x families,
> have different OPPs available for the MPU depending on which specific
> variant of the SoC is in use. This can be determined through use of the
> revision and an eFuse register present in the silicon. Introduce a
> ti-cpufreq driver that can read the aformentioned values and provide
> them as version matching data to the opp framework. Through this the
> opp-supported-hw dt binding that is part of the operating-points-v2
> table can be used to indicate availability of OPPs for each device.
> 
> This driver also creates the "cpufreq-dt" platform_device after passing
> the version matching data to the OPP framework so that the cpufreq-dt
> handles the actual cpufreq implementation. Even without the necessary
> data to pass the version matching data the driver will still create this
> device to maintain backwards compatibility with operating-points v1
> tables.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
> v2-v3:
>  - Use common ti compatible as described in binding and then match
>    against machine type for platform data.
>  - Use newly exposed dev_pm_opp_of_get_opp_desc_node to get
>    operating-points-v2 table now that properties needed by driver are
>    there.
>  - Parse syscon properties from operating-points-v2 node rather
>    than cpu node.
>  - Do not make ti-cpufreq a module-platform-driver and do not allow
>    building as module.
> 
>  drivers/cpufreq/Kconfig.arm  |  11 ++
>  drivers/cpufreq/Makefile     |   1 +
>  drivers/cpufreq/ti-cpufreq.c | 288 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 300 insertions(+)
>  create mode 100644 drivers/cpufreq/ti-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
