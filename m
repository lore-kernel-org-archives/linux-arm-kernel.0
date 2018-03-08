From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 8 Mar 2018 11:48:09 +0000
Subject: [PATCH v5 1/4] dt-bindings: firmware: Add bindings for ZynqMP
 firmware
In-Reply-To: <CY1PR0201MB0764FB23021F5DC694C7F56DB8D80@CY1PR0201MB0764.namprd02.prod.outlook.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
 <1519154467-2896-2-git-send-email-jollys@xilinx.com>
 <778329dd-76a7-0151-26d9-30e87e0c888d@arm.com>
 <CY1PR0201MB0764FB23021F5DC694C7F56DB8D80@CY1PR0201MB0764.namprd02.prod.outlook.com>
Message-ID: <f6a416b7-542f-a3c3-538f-8549cf4e96c3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/03/18 22:25, Jolly Shah wrote:
> Hi Sudeep,
> 

[...]

>>> +Examples:
>>> +	firmware {
>>> +		zynqmp_firmware: zynqmp-firmware {
>>> +			compatible = "xlnx,zynqmp-firmware";
>>> +			method = "smc";
>>> +		};
>>> +	};
>>>
>>
>> Do you foresee using SMC/HVC for this firmware even on future platforms?
>> If not, I suggest to keep the protocol part separate from the transport i.e.
>> smc/hvc via ATF. It could be replaced with mailbox or some h/w mechanism in
>> future ?
>>
> 
> We have PSCI and EEMI interfaces exposed to linux from ATF. PSCI is
> an EEMI client. We do not have current plans to switch to mailbox as it
> will require 2 communication channels to PMU as PSCI is through ATF.
> 

OK, but I just saw some bindings that has mailbox interface, honestly
it's getting too confusing with multiple series on the same thing
floating and hence I requested to put it together as one series.
-- 
Regards,
Sudeep
