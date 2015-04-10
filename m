From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 10 Apr 2015 15:43:21 -0500
Subject: [RFC PATCH 0/5] Add smp booting support for Qualcomm ARMv8 SoCs
Message-ID: <1428698605-13166-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for SMP boot on the MSM8x16 family of Qualcomm SoCs.

To support SMP on the MSM8x16 SoCs we need to add ARMv8/64-bit SCM interfaces to
setup the boot/release addresses for the secondary CPUs.  In addition we need
a uniquie set of cpu ops.  I'm aware the desired methods for booting secondary
CPUs is either via spintable or PSCI.  However, these SoCs are shipping with a
firmware that does not support those methods.

v2:
* Dropped introduction and use of CPU_METHOD_OF_DECLARE
* Moved qcom cpu ops from drivers/soc/qcom to arch/arm64/kernel
* Renamed msm to qcom in cpu ops code, minor cleans (remove dead defines/code)

- k

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
