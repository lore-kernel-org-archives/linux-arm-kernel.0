From: zhangshaokun@hisilicon.com (Zhangshaokun)
Date: Mon, 7 Aug 2017 16:57:48 +0800
Subject: [PATCH v4 0/6] Add HiSilicon SoC uncore Performance Monitoring
 Unit driver
In-Reply-To: <1500984642-204676-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1500984642-204676-1-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <a27a6e8e-6e26-977c-7df1-ab1cedae2a2c@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark/Will,

Appreciate your comments.

Thanks.
Shaokun

On 2017/7/25 20:10, Shaokun Zhang wrote:
> This patchset adds support for HiSilicon SoC uncore PMUs driver. It
> includes L3C, Hydra Home Agent (HHA) and DDRC.
> 
> Changes in v4:
> * remove redundant code and comments
> * reverse the functions order in exit function
> * remove some GPL information
> * revise including header file
> * fix Jonathan's other comments
> 
> Changes in v3:
> * rebase to 4.13-rc1
> * add dev_err if ioremap fails for PMUs
>  
> Changes in v2:
> * fix kbuild test robot error
> * make hisi_uncore_ops static
> 
> Shaokun Zhang (6):
>   Documentation: perf: hisi: Documentation for HiSilicon SoC PMU driver
>   perf: hisi: Add support for HiSilicon SoC uncore PMU driver
>   perf: hisi: Add support for HiSilicon SoC L3C PMU driver
>   perf: hisi: Add support for HiSilicon SoC HHA PMU driver
>   perf: hisi: Add support for HiSilicon SoC DDRC PMU driver
>   arm64: MAINTAINERS: hisi: Add HiSilicon SoC PMU support
> 
>  Documentation/perf/hisi-pmu.txt               |  52 +++
>  MAINTAINERS                                   |   7 +
>  drivers/perf/Kconfig                          |   7 +
>  drivers/perf/Makefile                         |   1 +
>  drivers/perf/hisilicon/Makefile               |   1 +
>  drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 420 ++++++++++++++++++++
>  drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  | 436 +++++++++++++++++++++
>  drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  | 538 ++++++++++++++++++++++++++
>  drivers/perf/hisilicon/hisi_uncore_pmu.c      | 398 +++++++++++++++++++
>  drivers/perf/hisilicon/hisi_uncore_pmu.h      | 103 +++++
>  include/linux/cpuhotplug.h                    |   1 +
>  11 files changed, 1964 insertions(+)
>  create mode 100644 Documentation/perf/hisi-pmu.txt
>  create mode 100644 drivers/perf/hisilicon/Makefile
>  create mode 100644 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
>  create mode 100644 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
>  create mode 100644 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
>  create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.c
>  create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.h
> 
