From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 05 Nov 2013 09:46:30 -0800
Subject: [PATCH 02/11] devicetree: bindings: Document Qualcomm cpus and
 enable-method
In-Reply-To: <1A27B0E2-FB92-488D-A0B3-65E677525720@codeaurora.org>
References: <1383343739-23080-1-git-send-email-sboyd@codeaurora.org>
 <1383343739-23080-3-git-send-email-sboyd@codeaurora.org>
 <CAL_JsqLObXEWJJ=SuifTjpPz9qTW0n43fyQNA-vjLNeLy-7-XA@mail.gmail.com>
 <20131104173606.GL21983@codeaurora.org>
 <378446F7-DC51-448D-AF99-93F98CEAFB03@codeaurora.org>
 <52792C60.2030405@codeaurora.org>
 <1A27B0E2-FB92-488D-A0B3-65E677525720@codeaurora.org>
Message-ID: <52792EF6.2040005@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/13 09:43, Kumar Gala wrote:
> On Nov 5, 2013, at 11:35 AM, Stephen Boyd wrote:
>
>> On 11/05/13 09:12, Kumar Gala wrote:
>>> I think this should be more specific than just 'qcom,mmio' or 'qcom,warm-boot'.  It should be 'qcom,kpss-acc-v1' or 'qcom-gcc-8660'.
>>>
>> Do you have any reasons why? I don't see why we need to keep adding more
>> and more enable-methods every time the subsystem surrounding the CPU
>> changes. The method is the same, write some registers to power up the
>> CPU for the first time (cold boot) or ping the CPU to wake it up
>> (warmboot). The only difference is where those registers live and a
>> slight variation in the sequence that we perform.
> By that argument every device could just be compatible with 'mmio' and be done with it ;)
>
> As the registers you write vary, the compatible should vary.

The compatible does vary. The enable-method is not a compatible property.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
