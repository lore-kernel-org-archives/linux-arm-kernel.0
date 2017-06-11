From: architt@codeaurora.org (Archit Taneja)
Date: Sun, 11 Jun 2017 11:28:47 +0530
Subject: [PATCH v3 2/6] dt-bindings: display: Add Synopsys DW MIPI DSI DRM
 bridge driver
In-Reply-To: <20170609130117.m5eyqrmv3gsokmuj@rob-hp-laptop>
References: <1496414235-20098-1-git-send-email-philippe.cornu@st.com>
 <1496414235-20098-3-git-send-email-philippe.cornu@st.com>
 <20170608154028.6ck3dos6de2dogrk@rob-hp-laptop>
 <7502cbc2-9feb-4dd3-3d95-b5f33b8a8872@codeaurora.org>
 <7dd31d6d-1d5d-2432-07aa-96349f50c924@synopsys.com>
 <20170609130117.m5eyqrmv3gsokmuj@rob-hp-laptop>
Message-ID: <68968927-13a7-2e93-113d-2c0a166c6422@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 6/9/2017 6:31 PM, Rob Herring wrote:
> On Fri, Jun 09, 2017 at 10:43:07AM +0100, Jose Abreu wrote:
>> Hello,
>>
>>
>> On 09-06-2017 05:11, Archit Taneja wrote:
>>> Hi Philippe, Rob,
>>>
>>> On 06/08/2017 09:10 PM, Rob Herring wrote:
>>>> Seems strange there's not also a pixel or bit clock? Or this
>>>> gets driven
>>>> from the phy?
>>>
>>> Since you mention phy here, I wanted to share a concern with
>>> the bindings.
>>> These bindings don't have a separate PHY DT node. The PHY is
>>> assumed as a
>>> part of the IP when integrated by a SoC. There are already
>>> rockchip and
>>> hisil DSI bindings that use this IP but don't define a PHY node.
>>>
>>> It's a similar situation with the DW-HDMI bindings.
>>>
>>> For example, when the DW HDMI is integrated in rockchip or
>>> renesas SoC, the
>>> bindings "rockchip,rk3288-dw-hdmi" or "renesas,r8a7795-dw-hdmi"
>>> are used,
>>> and they don't have a separate PHY DT node.
>>>
>>> I wasn't sure whether this is the right way to proceed or not
>>> for such IPs.
>>> Some advice would help us here.
>>>
>>> Thanks,
>>> Archit
>>>
>>
>> I just want to add that read/writes from/to phy are done using
>> the controller (in HDMI and in MIPI DSI Host), so the only way to
>> have a phy driver is that if some custom callbacks are provided
>> or if the memory region is shared.
>>
>> Anyway, I agree with Archit in the sense that phy + controller
>> are highly tied. Also, these two "pieces" are SoC specific and
>> sometimes very different between SoC's because they can be
>> customized so I think a different compatible string suits well here.
> 
> When the phy is integrated like this, I agree that it doesn't make sense
> to have a separate phy node.
>

Great. Thanks for the clarification Jose and Rob.

Archit

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
