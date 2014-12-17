From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed, 17 Dec 2014 11:25:09 -0700
Subject: [PATCH v14 00/10] cpuidle driver for QCOM SoCs: 8064, 8074, 8084
In-Reply-To: <7hegryb0te.fsf@deeprootsystems.com>
References: <1417541958-56907-1-git-send-email-lina.iyer@linaro.org>
 <7hegryb0te.fsf@deeprootsystems.com>
Message-ID: <20141217182509.GA1913@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17 2014 at 11:14 -0700, Kevin Hilman wrote:
>Lina Iyer <lina.iyer@linaro.org> writes:
>
>> Dependent patchsets -
>>         https://lkml.org/lkml/2014/8/4/767
>>         http://www.spinics.net/lists/linux-arm-msm/msg10799.html
>>         http://www.spinics.net/lists/linux-arm-msm/msg10795.html
>>
>> Changes since v13:
>> - Return values for idle states propagated back to the cpuidle driver.
>> - Remove static bool cpuidle_drv_init.
>> - Register cpuidle driver and cpuidle device separately.
>>  - cpuidle device registered only when the SPM for the cpu is probed.
>> - Initialization changes to ensure dynamic cpuidle devices are registered only
>>   after the cpuidle driver is registered.
>> - Removed wmb, replaced with a poll loop to ensure that the SPM registers are
>>   written before executing wfi.
>>   - Added spm_register_write_sync() for write guarantees.
>> - Removed irrelevant return value for spm_set_low_power_mode().
>> - Added comments, updated module description.
>> - Removed Reviewed-by and Acked-by on the spm and cpuidle-qcom patches.
>
>I think this series should also include updates to qcom_defconfig that
>enable QCOM_PM and the cpuidle driver.
>
>Then it will be enabled by default and get more broad testing.

Sure. I will be enabling them in the next revision of the series.

>
>Kevin
