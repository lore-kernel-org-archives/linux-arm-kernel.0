From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 13 Jan 2016 12:59:24 -0500
Subject: [PATCH V9 2/5] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <569265D6.5060407@codeaurora.org>
References: <1449850623-32214-1-git-send-email-okaya@codeaurora.org>
 <1449850623-32214-3-git-send-email-okaya@codeaurora.org>
 <20151211164137.GA23638@leverpostej> <566B1F64.9010500@codeaurora.org>
 <20151211193742.GD23638@leverpostej> <566B4ACC.3070005@codeaurora.org>
 <20151214120339.GA21356@leverpostej> <569265D6.5060407@codeaurora.org>
Message-ID: <5696907C.6000809@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, Rob, Frank, Grant and other DT experts;

>>>
>>> I'll add support for both. Both having a parent-child relationship while
>>> inside the hypervisor and flat hierarchy while running in the guest
>>> machine for QEMU.
>>
>> I'm happy with that.
>>
>>> I just created a child object of the management driver and channel
>>> driver got probed properly. So, it just a matter of device-tree
>>> documentation at this point.
>>>
>>> It will be like this though.
>>>
>>>>>> hidma {
>>>>>> 	compatible - "qcom,hidma-1.0";
>>>>>>
>>>>>> 	/* OPTIONAL management interface registers */
>>>>>> 	reg = < ... ... >;
>>>>>>
>>>>>> 	...
>>>>>>
>>>>>> 	channel0 {
>>>>>> 		compatible = "qcom,
>>>>>> 		reg = < ... ... >;
>>>>>>
>>>>>> 		...
>>>>>> 	};
>>>>>>
>>>>>> 	...
>>>>>> };
>>>
>>> This seems to have worked without requiring any work from me.
>>>
>>> I need to associate sysfs next.
>>
>> Ok. I look forward to seeing those patches.
>>
>> Thanks,
>> Mark.
>>
> 
> Mark,
> The patch has been posted here. Please review.
> 
> https://lkml.org/lkml/2016/1/3/246
> 
> Sinan
> 
> 
> 
> 

I have been trying to reach to device tree reviewers without any luck for the last two weeks. 
It must be the holidays. 

I have restructured the code address concerns from Mark Rutland above. The dma-engine maintainer, Vinod Koul;
is looking for an ACK from the DT community before the patches can be incorporated.

Could you please kindly review the series here from DT perspective and ACK it if you are OK?
https://lkml.org/lkml/2016/1/11/517

This document here
https://www.kernel.org/doc/linux/MAINTAINERS

tells me that Rob Herring, Frank Rowand and Grant Likely are the maintainers for device tree.

OPEN FIRMWARE AND FLATTENED DEVICE TREE
M:	Rob Herring <robh+dt@kernel.org>
M:	Frank Rowand <frowand.list@gmail.com>
M:	Grant Likely <grant.likely@linaro.org>
L:	devicetree at vger.kernel.org

That's why, I'm reaching out.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
