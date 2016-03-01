From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue, 1 Mar 2016 12:41:49 -0700
Subject: [RFC v2 12/12] ARM64: dts: Define CPU power domain for MSM8916
In-Reply-To: <20160226195035.GA28849@codeaurora.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
 <1455310238-8963-13-git-send-email-lina.iyer@linaro.org>
 <20160226195035.GA28849@codeaurora.org>
Message-ID: <20160301194149.GP1440@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26 2016 at 12:50 -0700, Stephen Boyd wrote:
>On 02/12, Lina Iyer wrote:
>> @@ -101,6 +105,27 @@
>>  		};
>>  	};
>>
>> +	CPU_PD: cpu-pd at 0 {
>> +		#power-domain-cells = <0>;
>> +		power-states = <&CLUSTER_RET>, <&CLUSTER_PWR_DWN>;
>
>Why isn't this part of the psci node? PSCI is the node that's
>providing the code/logic for the power domain.
>
I like that idea too. 
Lorenzo, what do you think?

>> +	};
>> +
>> +	pd-power-states {
>> +		CLUSTER_RET: power-state at 1 {
>> +			state-param = <0x1000010>;
>> +			entry-latency-us = <500>;
>> +			exit-latency-us = <500>;
>> +			residency-us = <2000>;
>> +		 };
>> +
>> +		CLUSTER_PWR_DWN: power-state at 2 {
>> +			state-param = <0x1000030>;
>> +			entry-latency-us = <2000>;
>> +			exit-latency-us = <2000>;
>> +			residency-us = <6000>;
>> +		};
>> +	};
>> +
>
>And I would expect these to be put somewhere inside the power
>domain provider as well? Is this documented somewhere?
>
Not yet, they will be, when it is submitted. This the glue patch that I
use on top of Axel's series to read domain states from DT, instead of
defining with the driver.

I have to discuss with Ulf, as to who is submitting that patch.

Thanks,
Lina

>>  	psci {
>>  		compatible = "arm,psci-1.0";
>>  		method = "smc";
>
>-- 
>Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>a Linux Foundation Collaborative Project
