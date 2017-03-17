From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Fri, 17 Mar 2017 10:30:33 -0400
Subject: [PATCH V4] perf: qcom: Add L3 cache PMU driver
In-Reply-To: <1489760657-26961-1-git-send-email-agustinv@codeaurora.org>
References: <1489760657-26961-1-git-send-email-agustinv@codeaurora.org>
Message-ID: <74bb476166cc6b7f378de337cfd4bfe7@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-03-17 10:24, Agustin Vega-Frias wrote:
> This adds a new dynamic PMU to the Perf Events framework to program
> and control the L3 cache PMUs in some Qualcomm Technologies SOCs.
> 
> The driver supports a distributed cache architecture where the overall
> cache for a socket is comprised of multiple slices each with its own 
> PMU.
> Access to each individual PMU is provided even though all CPUs share 
> all
> the slices. User space needs to aggregate to individual counts to 
> provide
> a global picture.
> 
> The driver exports formatting and event information to sysfs so it can
> be used by the perf user space tools with the syntaxes:
>    perf stat -a -e l3cache_0_0/read-miss/
>    perf stat -a -e l3cache_0_0/event=0x21/
> 
> Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
> ---
>  Documentation/perf/qcom_l3_pmu.txt |  25 ++
>  drivers/perf/Kconfig               |  10 +
>  drivers/perf/Makefile              |   1 +
>  drivers/perf/qcom_l3_pmu.c         | 825 
> +++++++++++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h         |   1 +
>  5 files changed, 862 insertions(+)
>  create mode 100644 Documentation/perf/qcom_l3_pmu.txt
>  create mode 100644 drivers/perf/qcom_l3_pmu.c

This was built and tested on top of v4.11-rc2.
The perf fuzzer was run overnight and no stability issues were found.

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
