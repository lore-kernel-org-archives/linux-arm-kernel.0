From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 15 Jun 2017 11:31:02 +0100
Subject: [PATCH 11/12] coresight tmc: Add support for Coresight SoC 600 TMC
In-Reply-To: <20170614182520.GF22030@xps15>
References: <1497278211-5001-1-git-send-email-suzuki.poulose@arm.com>
 <1497278211-5001-12-git-send-email-suzuki.poulose@arm.com>
 <20170614182520.GF22030@xps15>
Message-ID: <5066f809-7c3e-fe68-0db1-3d26b937e059@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/06/17 19:25, Mathieu Poirier wrote:
> On Mon, Jun 12, 2017 at 03:36:50PM +0100, Suzuki K Poulose wrote:
>> The coresight SoC 600 supports ETR save-restore and also supports
>> a new mode, SWFIFO2, which helps to streaming the trace data through
>> a functional I/O (e.g, USB).
>>
>> Also, TMCs have different PIDs in different configurations (ETF,
>> ETB & ETR), unlike the previous generation.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

...

>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
>> index d5ef51e..8c74e1e 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc.h
>> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
>> @@ -98,6 +98,12 @@ enum tmc_mem_intf_width {
>>   * value.
>>   */
>>  #define TMC_CAP_ETR_SAVE_RESTORE	(1U << 1)
>> +/*
>> + * TMC_CAP_ETR_SWFIFO2_MODE - ETR supports a new mode, SWFIFO2, which
>> + * allows streaming the trace data with optionally raising an interrupt
>> + * when the buffer fill level reaches a programmed watermark.
>> + */
>> +#define TMC_CAP_ETR_SWFIFO2_MODE	(1U << 2)
>>
>>  /**
>>   * struct tmc_cap - Describes the capabilities of the TMC.
>> @@ -108,6 +114,8 @@ struct tmc_caps {
>>  };
>>
>>  #define CORESIGHT_SOC_400_TMC_CAPS	(TMC_CAP_ETR_SG_UNIT)
>> +#define CORESIGHT_SOC_600_ETR_CAPS	(TMC_CAP_ETR_SAVE_RESTORE | \
>> +					 TMC_CAP_ETR_SWFIFO2_MODE)
>
> TMC_CAP_ETR_SWFIFO2_MODE isn't used anywhere - please remove.  It can be added
> when code that uses the feature is introduced.

Sure, will do.

Suzuki
