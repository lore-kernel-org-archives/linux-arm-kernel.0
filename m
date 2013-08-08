From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 08 Aug 2013 15:10:52 -0600
Subject: [RESEND PATCH 1/2] ARM: dts: Change dw-apb-timer-osc and
 dw-apb-timer-sp to just dw-apb-timer
In-Reply-To: <20130808210108.GA17855@amd.pavel.ucw.cz>
References: <1375740158-10012-1-git-send-email-dinguyen@altera.com>
 <5203FCEA.7040709@wwwdotorg.org> <20130808210108.GA17855@amd.pavel.ucw.cz>
Message-ID: <5204095C.9010504@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2013 03:01 PM, Pavel Machek wrote:
> On Thu 2013-08-08 14:17:46, Stephen Warren wrote:
>> On 08/05/2013 04:02 PM, dinguyen at altera.com wrote:
>>> From: Dinh Nguyen <dinguyen@altera.com>
>>>
>>> "dw-apb-timer-osc" and "dw-apb-timer-sp" are the same implementation of the
>>> DW APB timer, just fed by different clocks.
>>
>> I assume patch 1/1 made similar changes to the driver?
>>
>>> diff --git a/Documentation/devicetree/bindings/rtc/dw-apb.txt b/Documentation/devicetree/bindings/rtc/dw-apb.txt
>>
>>>  Required properties:
>>> -- compatible: "snps,dw-apb-timer-sp" or "snps,dw-apb-timer-osc"
>>> +- compatible: "snps,dw-apb-timer"
>>
>> This change is problematic w.r.t device tree as an ABI. any DT that uses
>> the new value "snps,dw-apb-timer" will not work with older software that
>> was written to expect the old values.
> 
> I'm pretty sure there's no such software out there. Actually, I don't
> think timers ever worked properly on any mainline kernels.
> 
> So I believe we can still fix it the right way... it is same hardware
> with different labels after all.

If even Linux 3.11 isn't going to work properly with the current DT
content, then I think breaking ABI compatibility is fine.
