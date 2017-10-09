From: zhangshaokun@hisilicon.com (Zhangshaokun)
Date: Mon, 9 Oct 2017 16:17:26 +0800
Subject: [PATCH v5 0/6] Add HiSilicon SoC uncore Performance Monitoring
 Unit driver
In-Reply-To: <2a9d317a-3811-9661-8211-fc779b27458c@hisilicon.com>
References: <1503389277-134131-1-git-send-email-zhangshaokun@hisilicon.com>
 <2a9d317a-3811-9661-8211-fc779b27458c@hisilicon.com>
Message-ID: <65066742-69a9-c9b1-0880-8d09c339406c@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Do you have any comments on this patch set?

Thanks,
Shaokun

On 2017/9/21 18:40, Zhangshaokun wrote:
> Hi Mark/Will,
> 
> Appreciate any comments from you.
> 
> Thanks,
> Shaokun
> 
> On 2017/8/22 16:07, Shaokun Zhang wrote:
>> This patchset adds support for HiSilicon SoC uncore PMUs driver. It
>> includes L3C, Hydra Home Agent (HHA) and DDRC.
>>
>> Changes in v5:
>> * remove unnecessary name/num_events member in hisi_pmu
>> * refactor hisi_pmu_hwevents structure
>> * remove hisi_pmu_alloc function
>> * revise cpuhotplug for L3C PMUs
>> * add cpuhotplug for HHA/DDRC PMUs
>> * fix the name format of uncore PMUs
>> * remove unnecessary variants
>>
>> Changes in v4:
>> * remove redundant code and comments
>> * reverse the functions order in exit function
>> * remove some GPL information
>> * revise including header file
>> * fix Jonathan's other comments
>>
>> Changes in v3:
>> * rebase to 4.13-rc1
>> * add dev_err if ioremap fails for PMUs
>>  
>> Changes in v2:
>> * fix kbuild test robot error
>> * make hisi_uncore_ops static
>>
>> Shaokun Zhang (6):
>>   Documentation: perf: hisi: Documentation for HiSilicon SoC PMU driver
>>   perf: hisi: Add support for HiSilicon SoC uncore PMU driver
>>   perf: hisi: Add support for HiSilicon SoC L3C PMU driver
>>   perf: hisi: Add support for HiSilicon SoC HHA PMU driver
>>   perf: hisi: Add support for HiSilicon SoC DDRC PMU driver
>>   arm64: MAINTAINERS: hisi: Add HiSilicon SoC PMU support
>>
>>  Documentation/perf/hisi-pmu.txt               |  53 +++
>>  MAINTAINERS                                   |   7 +
>>  drivers/perf/Kconfig                          |   7 +
>>  drivers/perf/Makefile                         |   1 +
>>  drivers/perf/hisilicon/Makefile               |   1 +
>>  drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 467 +++++++++++++++++++++++++
>>  drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  | 477 +++++++++++++++++++++++++
>>  drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  | 482 ++++++++++++++++++++++++++
>>  drivers/perf/hisilicon/hisi_uncore_pmu.c      | 440 +++++++++++++++++++++++
>>  drivers/perf/hisilicon/hisi_uncore_pmu.h      | 107 ++++++
>>  include/linux/cpuhotplug.h                    |   3 +
>>  11 files changed, 2045 insertions(+)
>>  create mode 100644 Documentation/perf/hisi-pmu.txt
>>  create mode 100644 drivers/perf/hisilicon/Makefile
>>  create mode 100644 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
>>  create mode 100644 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
>>  create mode 100644 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
>>  create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.c
>>  create mode 100644 drivers/perf/hisilicon/hisi_uncore_pmu.h
>>
> 
> 
> .
> 
