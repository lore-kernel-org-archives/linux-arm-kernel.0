From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 30 Jan 2015 15:48:26 -0600
Subject: [Patch v2 1/6] soc: qcom: gsbi: Add support for ADM CRCI muxing
In-Reply-To: <54CBF9AE.6060902@codeaurora.org>
References: <1422599135-5588-1-git-send-email-agross@codeaurora.org>
 <1422599135-5588-2-git-send-email-agross@codeaurora.org>
 <B36DEAB1-2D89-4B6B-991E-C2EDBEB684D9@codeaurora.org>
 <54CBF9AE.6060902@codeaurora.org>
Message-ID: <C168E827-6052-4A7B-80EA-6330E8E08D51@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Jan 30, 2015, at 3:37 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 01/30/15 08:32, Kumar Gala wrote:
>> On Jan 30, 2015, at 12:25 AM, Andy Gross <agross@codeaurora.org> wrote:
>> 
>>> Required properties if child node exists:
>>> - #address-cells: Must be 1
>>> - #size-cells: Must be 1
>>> - ranges: Must be present
>>> 
>>> +Note: Each GSBI should have an alias correctly numbered in "aliases" node.
>>> +
>>> Properties for children:
>>> 
>>> A GSBI controller node can contain 0 or more child nodes representing serial
>>> @@ -37,6 +41,10 @@ Example for APQ8064:
>>> 
>>> #include <dt-bindings/soc/qcom,gsbi.h>
>>> 
>>> +	aliases {
>>> +		gsbi4 = <&gsbi4>;
>>> +	};
>> You appear to be using the alias name to determine a index number for the gsbi, if that is the case, than you should probably just add a cell-index node to the gsbi?s for this purpose.
>> 
> 
> I thought cell-index was "deprecated" and referred more to things like
> enumerating all the devices on a bus by assigning them a unique ID.
> Aliases, on the other hand, allow us to enumerate a subset of devices
> that share the same bus with other devices of different types. For
> example, how would I know that a device is gsbi1 vs serial1 if they both
> used cell-index and they both had the same parent node?

I think the problem was cell-index was never well understood and abused.  For the example you are giving you wouldn?t use cell-index because you are talking about things that would have different compatibles.  For what it appears we really are enumerating the GSBI hardware to match some programming interface convention.  If that is the case than I think cell-index is proper.

- k

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
