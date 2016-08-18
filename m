From: john.garry@huawei.com (John Garry)
Date: Thu, 18 Aug 2016 12:59:31 +0100
Subject: [RFC PATCH v1 00/10] arm64:perf: Support for Hisilicon SoC
 Hardware event counters
In-Reply-To: <1470301634-79736-1-git-send-email-anurup.m@huawei.com>
References: <1470301634-79736-1-git-send-email-anurup.m@huawei.com>
Message-ID: <57B5A323.1040504@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2016 10:07, Anurup M wrote:

Hi Anurup,

Mark already kindly gave feedback to your original patchset in June. I 
think many of the comments he gave have been addressed in this patchset.

However, I think that if you want your driver to be reviewed and 
accepted then you should drop the "RFC" and ensure it is ready be be 
accepted. I think that it is unreasonable to expect the maintainers to 
just give comments again.

Thanks,
John

> [Note: Resending the patch series as I missed to add Maintainers in --to field]
>
> Provide Support for Hisilicon SoC Hip05 Hardware event counters.
> The Hisilicon SoC Hip05 series has many uncore or non-CPU performance
> events and counters units.
>
> This patch is implemented refering to arm-cci, Intel/AMD uncore and
> also the cavium thunderX pmu patches.
>
> Support for Hisilicon L3 cache(LLC) hardware events and counters are added
> in this implementation.
>
> The Hisilicon PMU datastructures are designed so as to support uncore
> and also CPU specific events in future.
>
> The Hisilicon LLC has four banks for a Super CPU Cluster(consists of
>   16 CPU cores) and each LLC bank has separate hardware events and counters.
> In the current implementation, the count from all these banks are summarized
> and total count is output.
>
> Hisilicon SoC use Djtag interface for r/w access to SoC PMU registers
>
> The Hisilicon uncore PMUs can be found under /sys/bus/event_source/devices.
> The counters are exported via sysfs in the corresponding events files
> under the PMU directory so the perf tool can list the event names.
>
> Note:
> This is very initial patchset for Hisilicon Hip05 SoC PMU support shared for
> review. Please review and share comments.
>
> TODO:
> 	1. Counter overflow interrupt handling support.
> 	2. CPU notifier to migrate to available online CPU's in case
> 	   of CPU DOWN. Also mapping CPU cores to the current SCCL.
> 	3. Support for counting of individual LLC banks
>
> Anurup M (8):
>    arm64:perf: Add Documentaion for HIP05 PMU event counting.
>      1. Documentaion for perf usage and PMU events.
>    arm64:perf: Add Devicetree bindings for Hisilicon SoC PMU
>    arm64:perf: Update Kconfig for Hisilicon PMU support
>    arm64:perf: Add support for Hisilicon SoC event counters
>    arm64:perf: Makefile for Hisilicon Hip05 PMU
>    arm64:perf: Update Makefile for Hisilicon PMU support
>    arm64:perf: L3 cache(LLC) event listing in perf
>    arm64: dts: hip05: Add L3 cache PMU support
>
> Tan Xiaojun (2):
>    Documentation: arm64: Add Hisilicon HiP05/06/07 Sysctrl and Djtag dts
>      bindings
>    drivers: soc: Add support for Hisilicon Djtag driver
>
>   .../bindings/arm/hisilicon/hisilicon.txt           |  97 ++++
>   .../devicetree/bindings/arm/hisilicon/pmu.txt      |  52 ++
>   Documentation/perf/hip05-pmu.txt                   |  70 +++
>   arch/arm64/boot/dts/hisilicon/hip05.dtsi           |  19 +
>   drivers/perf/Kconfig                               |   9 +
>   drivers/perf/Makefile                              |   1 +
>   drivers/perf/hisilicon/Makefile                    |   1 +
>   drivers/perf/hisilicon/hisi_uncore_l3c.c           | 561 +++++++++++++++++++++
>   drivers/perf/hisilicon/hisi_uncore_l3c.h           | 100 ++++
>   drivers/perf/hisilicon/hisi_uncore_pmu.c           | 504 ++++++++++++++++++
>   drivers/perf/hisilicon/hisi_uncore_pmu.h           | 148 ++++++
>   drivers/soc/Kconfig                                |   1 +
>   drivers/soc/Makefile                               |   1 +
>   drivers/soc/hisilicon/Kconfig                      |  12 +
>   drivers/soc/hisilicon/Makefile                     |   1 +
>   drivers/soc/hisilicon/djtag.c                      | 373 ++++++++++++++
>   include/linux/soc/hisilicon/djtag.h                |  18 +
>   17 files changed, 1968 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
>   create mode 100644 Documentation/perf/hip05-pmu.txt
>   create mode 100644 drivers/perf/hisilicon/Makefile
>   create mode 100644 drivers/perf/hisilicon/hisi_uncore_l3c.c
>   create mode 100644 drivers/perf/hisilicon/hisi_uncore_l3c.h
>   create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.c
>   create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.h
>   create mode 100644 drivers/soc/hisilicon/Kconfig
>   create mode 100644 drivers/soc/hisilicon/Makefile
>   create mode 100644 drivers/soc/hisilicon/djtag.c
>   create mode 100644 include/linux/soc/hisilicon/djtag.h
>
