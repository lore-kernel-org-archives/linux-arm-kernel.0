From: tbaicar@codeaurora.org (Tyler Baicar)
Date: Wed, 1 Nov 2017 13:02:19 -0400
Subject: [PATCH 0/5] arm_pmu: fix lockdep issues with ACPI systems
In-Reply-To: <20171101141239.45340-1-mark.rutland@arm.com>
References: <20171101141239.45340-1-mark.rutland@arm.com>
Message-ID: <f0fee30c-aa96-1f6d-a264-854f17590035@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/1/2017 10:12 AM, Mark Rutland wrote:
> Currently the arm_pmu ACPI code is somewhat dubious. It attempts ot
> allocate memory any manpiulate IRQs in a hotplug callback, which is an
> atomic context.
>
> These patches (based on the arm64 for-next/core branch [1]) attempt to
> address this by moving work out of hotplug callback, requiring a
> reorganisation of the common arm_pmu code.
>
> I've given these a boot-test on a Juno R1 system, both with DT and ACPI.
> In either case the PMU works as expected, and lockdep seems happy.
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>

Boot tested on Qualcomm Centriq 2400 and verified I no longer see the BUG print.

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
