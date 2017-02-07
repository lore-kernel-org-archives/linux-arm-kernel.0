From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 7 Feb 2017 10:52:35 -0600
Subject: [PATCH v5 0/4] cpufreq: Introduce TI CPUFreq/OPP Driver
In-Reply-To: <20170207165107.29394-1-d-gerlach@ti.com>
References: <20170207165107.29394-1-d-gerlach@ti.com>
Message-ID: <4900edde-02b9-cba4-4b89-45c20cfc5571@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2017 10:51 AM, Dave Gerlach wrote:
> Hi,
> This is v5 of the series to introduce the ti-cpufreq driver
> which parses SoC data and provides opp-supported-hw data to the
> OPP core in order to enable the proper OPPs for the silicon in use.
>

Sorry for the noise, already sent this as a proper series, just accidentally 
resent the cover letter.

Regards,
Dave

> History:
> v4: http://www.spinics.net/lists/linux-omap/msg134629.html
> v3: http://www.spinics.net/lists/linux-omap/msg132733.html
> v2: http://www.spinics.net/lists/linux-omap/msg131601.html
> v1: http://www.spinics.net/lists/linux-omap/msg129089.html
>
> Very minor changes from v4:
> 	* In patch 2 change "opp_table0" to "opp_table" in example
> 	* Add acks on all patches (he approved change in patch 2) from Viresh
>
> DT patches to enable this driver will follow after the DT binding is merged.
> Branch for testing, with updated DT nodes, pushed here [1].
>
> Regards,
> Dave
>
> [1] https://github.com/dgerlach/linux-pm/commits/upstream/ti-cpufreq-driver-new-v5
>
> Dave Gerlach (4):
>   PM / OPP: Expose _of_get_opp_desc_node as dev_pm_opp API
>   Documentation: dt: add bindings for ti-cpufreq
>   cpufreq: ti: Add cpufreq driver to determine available OPPs at runtime
>   cpufreq: dt: Don't use generic platdev driver for ti-cpufreq platforms
>
>  .../devicetree/bindings/cpufreq/ti-cpufreq.txt     | 128 ++++++++++
>  drivers/base/power/opp/of.c                        |   9 +-
>  drivers/cpufreq/Kconfig.arm                        |  11 +
>  drivers/cpufreq/Makefile                           |   1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c               |   2 -
>  drivers/cpufreq/ti-cpufreq.c                       | 272 +++++++++++++++++++++
>  include/linux/pm_opp.h                             |   6 +
>  7 files changed, 423 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
>  create mode 100644 drivers/cpufreq/ti-cpufreq.c
>
