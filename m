From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 10 Mar 2015 16:24:50 +0000
Subject: [PATCH 4/5] arm-cci: Split the code for PMU vs driver support
In-Reply-To: <1426000735-14375-5-git-send-email-suzuki.poulose@arm.com>
References: <1426000735-14375-1-git-send-email-suzuki.poulose@arm.com>
 <1426000735-14375-5-git-send-email-suzuki.poulose@arm.com>
Message-ID: <54FF1AD2.8090105@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/03/15 15:18, Suzuki K. Poulose wrote:
> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>
> This patch separates the PMU driver code from the low level
> CCI driver code and enables the PMU driver for ARM64.
>
> Introduces config options for both.
>
>   ARM_CCI400_PORT_CTRL	- controls the low level driver code for
> 			  CCI400 ports.
>   ARM_CCI400_PMU 	- controls the PMU driver code
>   ARM_CCI400_COMMON 	- Common defintions for CCI400
>
> This patch also changes:
>   ARM_CCI - common code for probing the CCI devices. This can be
>     used for adding support for newer CCI versions(e.g, CCI-500).
>
> Changes since V2:
>    - Make ARM_CCI400_PMU default y (Suggested-by: Sudeep Holla)
> Changes since V1 (Suggestions-by: Nicolas Pitre):
>    - Renames
> 	CONFIG_ARM_CCI400_MCPM => CONFIG_ARM_CCI400_PORT_CTRL
> 	CCI400_MCPM_PORTS_DATA => CCI400_PORTS_DATA
>    - Select ARM_CCI400_COMMON for ARM_CCI400_PORT_CTRL
>    - Better documentation in the git commit log about the ARM_CCI config.
>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Abhilash Kesavan <a.kesavan@samsung.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

For vexpress changes,
Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Regards,
Sudeep
