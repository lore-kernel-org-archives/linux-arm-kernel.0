From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 30 Jan 2015 13:37:50 -0800
Subject: [Patch v2 1/6] soc: qcom: gsbi: Add support for ADM CRCI muxing
In-Reply-To: <B36DEAB1-2D89-4B6B-991E-C2EDBEB684D9@codeaurora.org>
References: <1422599135-5588-1-git-send-email-agross@codeaurora.org>
 <1422599135-5588-2-git-send-email-agross@codeaurora.org>
 <B36DEAB1-2D89-4B6B-991E-C2EDBEB684D9@codeaurora.org>
Message-ID: <54CBF9AE.6060902@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/15 08:32, Kumar Gala wrote:
> On Jan 30, 2015, at 12:25 AM, Andy Gross <agross@codeaurora.org> wrote:
>
>> Required properties if child node exists:
>> - #address-cells: Must be 1
>> - #size-cells: Must be 1
>> - ranges: Must be present
>>
>> +Note: Each GSBI should have an alias correctly numbered in "aliases" node.
>> +
>> Properties for children:
>>
>> A GSBI controller node can contain 0 or more child nodes representing serial
>> @@ -37,6 +41,10 @@ Example for APQ8064:
>>
>> #include <dt-bindings/soc/qcom,gsbi.h>
>>
>> +	aliases {
>> +		gsbi4 = <&gsbi4>;
>> +	};
> You appear to be using the alias name to determine a index number for the gsbi, if that is the case, than you should probably just add a cell-index node to the gsbi?s for this purpose.
>

I thought cell-index was "deprecated" and referred more to things like
enumerating all the devices on a bus by assigning them a unique ID.
Aliases, on the other hand, allow us to enumerate a subset of devices
that share the same bus with other devices of different types. For
example, how would I know that a device is gsbi1 vs serial1 if they both
used cell-index and they both had the same parent node?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
