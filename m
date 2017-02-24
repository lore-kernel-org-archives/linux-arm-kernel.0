From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 24 Feb 2017 15:58:14 -0600
Subject: [PATCH V2] perf: qcom: Add L3 cache PMU driver
In-Reply-To: <1487257385-28930-1-git-send-email-agustinv@codeaurora.org>
References: <1487257385-28930-1-git-send-email-agustinv@codeaurora.org>
Message-ID: <09a4f5a1-d306-43db-ce7e-03c5c87440c4@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/16/2017 09:03 AM, Agustin Vega-Frias wrote:
> +config QCOM_L3_PMU
> +	 bool "Qualcomm Technologies L3-cache PMU"
> +	 depends on ARCH_QCOM && ARM64 && PERF_EVENTS && ACPI
> +	   help
> +	   Provides support for the L3 cache performance monitor unit (PMU)
> +	   in Qualcomm Technologies processors.
> +	   Adds the L3 cache PMU into the perf events subsystem for
> +	   monitoring L3 cache events.

Since the L3 PMU driver doesn't work without the IRQ combiner driver, I think 
you need to add:

     select QCOM_IRQ_COMBINER

or

     depends on QCOM_IRQ_COMBINER

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
