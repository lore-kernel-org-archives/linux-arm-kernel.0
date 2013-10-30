From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 30 Oct 2013 14:48:21 -0700
Subject: [PATCH v2 4/6] edac: Document Krait L1/L2 EDAC driver binding
In-Reply-To: <872F86E8-85CE-472B-9546-CDCC96F6F08B@codeaurora.org>
References: <1383164736-1849-1-git-send-email-sboyd@codeaurora.org>
 <1383164736-1849-5-git-send-email-sboyd@codeaurora.org>
 <872F86E8-85CE-472B-9546-CDCC96F6F08B@codeaurora.org>
Message-ID: <52717EA5.6030208@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/13 14:45, Kumar Gala wrote:
> On Oct 30, 2013, at 3:25 PM, Stephen Boyd wrote:
>
>> @@ -75,3 +77,50 @@ Example:
>> 			reg = <0x101>;
>> 		};
>> 	};
>> +
>> +If the compatible string contains "qcom,krait" there shall be an interrupts
>> +property containing the L1/CPU error interrupt number. There shall also be an
> 'also be a'

ok

>
>> +l2-cache node containing the following properties:
> Is the L1 interrupt not per core L1 cache (even if they are OR together at PIC)?

Yes it is per CPU. That is what the 0xf part of the cpus interrupts
property is showing.

>
>> +
>> + - compatible: Shall contain at least "cache"
>> + - cache-level: Must be 2
>> + - interrupts: Shall contain the L2 error interrupt
>> +
>> +Example:
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		interrupts = <1 9 0xf04>;
>> +		compatible = "qcom,krait";
>>


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
