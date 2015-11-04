From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 4 Nov 2015 18:20:13 +0000
Subject: [PATCHv2 2/4] arm-cci: Get the status of a counter
In-Reply-To: <20151104180651.GG23860@leverpostej>
References: <1445346326-30820-1-git-send-email-suzuki.poulose@arm.com>
 <1445346326-30820-3-git-send-email-suzuki.poulose@arm.com>
 <20151104180651.GG23860@leverpostej>
Message-ID: <563A4C5D.4010703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/15 18:06, Mark Rutland wrote:
> On Tue, Oct 20, 2015 at 02:05:24PM +0100, Suzuki K. Poulose wrote:
>> Add helper routines to get the counter status and the event
>> programmed on it.
>>

>> +static u32 pmu_get_counter_ctrl(struct cci_pmu *cci_pmu, int idx)
>> +{
>> +	return pmu_read_register(cci_pmu, idx, CCI_PMU_CNTR_CTRL) & 0x1;
>> +}
>
> Given the function is called pmu_get_counter_ctrl, why the '& 1'?

Thats because the Count Control has only 1 bit defined. The rest is RES0.

>
> Either this should return the raw value, or the function should be
> renamed to something like pmu_counter_is_enabled, and made bool.

Makes sense. I will change it to pmu_counter_is_enabled().

Thanks
Suzuki
