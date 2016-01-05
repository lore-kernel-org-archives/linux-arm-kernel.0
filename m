From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 5 Jan 2016 09:50:49 +0000
Subject: [PATCH v5 01/11] arm-cci: Define CCI counter period
In-Reply-To: <20160104181940.GA17127@leverpostej>
References: <1451908490-2615-1-git-send-email-suzuki.poulose@arm.com>
 <1451908490-2615-2-git-send-email-suzuki.poulose@arm.com>
 <20160104181940.GA17127@leverpostej>
Message-ID: <568B91F9.6010307@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/16 18:27, Mark Rutland wrote:
> On Mon, Jan 04, 2016 at 11:54:40AM +0000, Suzuki K. Poulose wrote:
>> Instead of hard coding the period we program on the PMU
>> counters, define a symbol.
>>

>> -	u64 val = 1ULL << 31;
>> -	local64_set(&hwc->prev_count, val);
>> -	pmu_write_counter(event, val);
>> +	local64_set(&hwc->prev_count, CCI_CNTR_PERIOD);
>> +	pmu_write_counter(event, CCI_CNTR_PERIOD);
>
> I think this is a little misleading (and confusing), as we're conflating
> the period with its inverse. This wouldn't work for any other value of
> CCI_CNTR_PERIOD.
>
> Perhaps s/PERIOD/START_VAL/, leaving everything else as-is?

You are right, will change it.

Cheers
Suzuki
