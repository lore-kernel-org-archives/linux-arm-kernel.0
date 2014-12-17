From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 17 Dec 2014 10:14:53 -0800
Subject: [PATCH v14 00/10] cpuidle driver for QCOM SoCs: 8064, 8074, 8084
In-Reply-To: <1417541958-56907-1-git-send-email-lina.iyer@linaro.org> (Lina
 Iyer's message of "Tue, 2 Dec 2014 10:39:08 -0700")
References: <1417541958-56907-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <7hegryb0te.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lina Iyer <lina.iyer@linaro.org> writes:

> Dependent patchsets - 
>         https://lkml.org/lkml/2014/8/4/767
>         http://www.spinics.net/lists/linux-arm-msm/msg10799.html
>         http://www.spinics.net/lists/linux-arm-msm/msg10795.html
>
> Changes since v13:
> - Return values for idle states propagated back to the cpuidle driver.
> - Remove static bool cpuidle_drv_init.
> - Register cpuidle driver and cpuidle device separately.
>  - cpuidle device registered only when the SPM for the cpu is probed.
> - Initialization changes to ensure dynamic cpuidle devices are registered only
>   after the cpuidle driver is registered.
> - Removed wmb, replaced with a poll loop to ensure that the SPM registers are
>   written before executing wfi.
>   - Added spm_register_write_sync() for write guarantees.
> - Removed irrelevant return value for spm_set_low_power_mode().
> - Added comments, updated module description.
> - Removed Reviewed-by and Acked-by on the spm and cpuidle-qcom patches.

I think this series should also include updates to qcom_defconfig that
enable QCOM_PM and the cpuidle driver.

Then it will be enabled by default and get more broad testing.

Kevin
