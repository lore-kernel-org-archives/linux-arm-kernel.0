From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 30 Sep 2014 11:02:53 -0500
Subject: [PATCH v7 1/3] mfd: devicetree: bindings: Add Qualcomm RPM DT
 binding
In-Reply-To: <20140930152838.GN28481@sonymobile.com>
References: <1411428329-23172-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1411428329-23172-2-git-send-email-bjorn.andersson@sonymobile.com>
 <334C6A04-9607-4E97-A7A7-2FEED5986E57@codeaurora.org>
 <20140930152838.GN28481@sonymobile.com>
Message-ID: <2FC56515-E6AF-4A4D-9B04-70B4A8B2C4C7@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sep 30, 2014, at 10:28 AM, Bjorn Andersson <Bjorn.Andersson@sonymobile.com> wrote:

> On Wed 24 Sep 09:39 PDT 2014, Kumar Gala wrote:
> 
>> 
>> On Sep 22, 2014, at 6:25 PM, Bjorn Andersson <Bjorn.Andersson@sonymobile.com> wrote:
>> 
> 
> [..]
> 
>>> diff --git a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
> 
> [..]
> 
>>> +- qcom,ipc:
>>> +     Usage: required
>>> +     Value type: <prop-encoded-array>
>>> +
>>> +     Definition: three entries specifying the outgoing ipc bit used for
>>> +                 signaling the RPM:
>>> +                 - phandle to a syscon node representing the apcs registers
>>> +                 - u32 representing offset to the register within the syscon
>>> +                 - u32 representing the ipc bit within the register
>>> +
>> 
>> Does this really ever differ for the SoCs, and even if it does why do we need
>> to encode it in DT.  Can?t we determine it via the compatible setting?
>> 
> 
> The two offsets could be hard coded, especially based on the compatible.
> 
> But I don't know if it's worth respinning this just to get those two number out
> of here. Also this is now "symmetric" with the smd use cases, where it
> shouldn't be hard coded.

I do think its worth respinning until the DT is agreed to as we shouldn?t be changing the binding.

I?m not sure how being ?symmetric? with the smd use case maters if we are treating this RPM support vs RPM-SMD as two different things.

- k
-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
