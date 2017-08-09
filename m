From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 9 Aug 2017 15:56:13 +0800
Subject: [PATCH 0/2] arm64 SMMUv3 PMU driver with IORT support
In-Reply-To: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
Message-ID: <394bd3b8-2583-01fa-02d3-6a49c2a6a6c0@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On 2017/8/5 3:59, Neil Leeder wrote:
> This adds a driver for the SMMUv3 PMU into the perf framework.
> It includes an IORT update to support PM Counter Groups.
> 
> IORT has no mechanism for determining device names so PMUs
> are named based on their physical address.
> 
> Tested on Qualcomm QDF2400. perf_fuzzer ran for 4+ hours
> with no failures.
> 
> Neil Leeder (2):
>    acpi: arm64: add iort support for PMCG
>    perf: add arm64 smmuv3 pmu driver
> 
>   drivers/acpi/arm64/iort.c     |  54 +++

I would like to be Cced for next version.

>   drivers/perf/Kconfig          |   9 +
>   drivers/perf/Makefile         |   1 +
>   drivers/perf/arm_smmuv3_pmu.c | 823 ++++++++++++++++++++++++++++++++++++++++++
>   include/acpi/actbl2.h         |   9 +-

Do you have the acpica support code? I'm currently
working on SMMUv3 MSI support and I would like to test
it with MSI support for PMCG as well.

Thanks
Hanjun

>   5 files changed, 895 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/perf/arm_smmuv3_pmu.c
> 
