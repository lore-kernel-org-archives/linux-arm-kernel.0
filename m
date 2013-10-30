From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 30 Oct 2013 16:56:19 -0500
Subject: [PATCH v2 4/6] edac: Document Krait L1/L2 EDAC driver binding
In-Reply-To: <52717EA5.6030208@codeaurora.org>
References: <1383164736-1849-1-git-send-email-sboyd@codeaurora.org>
 <1383164736-1849-5-git-send-email-sboyd@codeaurora.org>
 <872F86E8-85CE-472B-9546-CDCC96F6F08B@codeaurora.org>
 <52717EA5.6030208@codeaurora.org>
Message-ID: <F38814D8-723E-4A41-839D-DEE351738017@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 30, 2013, at 4:48 PM, Stephen Boyd wrote:

> On 10/30/13 14:45, Kumar Gala wrote:
>> On Oct 30, 2013, at 3:25 PM, Stephen Boyd wrote:
>> 
>>> @@ -75,3 +77,50 @@ Example:
>>> 			reg = <0x101>;
>>> 		};
>>> 	};
>>> +
>>> +If the compatible string contains "qcom,krait" there shall be an interrupts
>>> +property containing the L1/CPU error interrupt number. There shall also be an
>> 'also be a'
> 
> ok
> 
>> 
>>> +l2-cache node containing the following properties:
>> Is the L1 interrupt not per core L1 cache (even if they are OR together at PIC)?
> 
> Yes it is per CPU. That is what the 0xf part of the cpus interrupts
> property is showing.

Than why not have it in each cpu node?

>>> 
>>> + - compatible: Shall contain at least "cache"
>>> + - cache-level: Must be 2
>>> + - interrupts: Shall contain the L2 error interrupt
>>> +
>>> +Example:
>>> +
>>> +	cpus {
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +		interrupts = <1 9 0xf04>;
>>> +		compatible = "qcom,krait";
>>> 


- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
