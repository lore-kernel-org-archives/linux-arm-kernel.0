From: anuragku@xilinx.com (Anurag Kumar Vulisha)
Date: Wed, 5 Sep 2018 09:32:23 +0000
Subject: [PATCH v2 2/2] phy: zynqmp: Add dt bindings for ZynqMP phy
In-Reply-To: <2831a270-a4d1-ba51-e13f-85c029bbe8c0@codeaurora.org>
References: <1535976844-12494-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1535976844-12494-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <2831a270-a4d1-ba51-e13f-85c029bbe8c0@codeaurora.org>
Message-ID: <BN3PR0201MB0993F5B9CAAFB3DF83A200B6A7020@BN3PR0201MB0993.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

>> +Phy provider node
>> +=================
>> +
>> +Required properties:
>> +- compatible	: Can be "xlnx,zynqmp-psgtr-v1.1" or "xlnx,zynqmp-psgtr"
>> +		  "xlnx,zynqmp-psgtr-v1.1" has "xlnx,tx_termination_fix" removed
>This is not very clear. You can rather mention this statement for the property.
>e.g. In "xlnx,tx_termination_fix" you can write - this is not required for "xlnx,zynqmp-
>psgtr-v1.1.
>

Thanks for spending your time in reviewing this patch,  will correct this in the
next series of patch.
 
>> +
>> +- reg           : Address and length of register sets for each device in
>> +                  "reg-names"
>> +
>> +- reg-names     : The names of the register addresses corresponding to the
>> +
>> +lane1:
>> +- #phy-cells	: Should be 4
>> +
>> +lane2:
>> +- #phy-cells	: Should be 4
>> +
>> +lane3:
>> +- #phy-cells	: Should be 4
>> +
>> +Example:
>> +	serdes: zynqmp_phy at fd400000 {
>
>phy is not just the serdes. Also s/zynqmp_phy/phy
>
>This could be:
> ??????????????????? zynqmp_phy: phy at fd400000
>
Thanks for correcting, will fix this in next series of this patch

Best Regards,
Anurag Kumar Vulisha
