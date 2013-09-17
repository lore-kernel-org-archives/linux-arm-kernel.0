From: mikedunn@newsguy.com (Mike Dunn)
Date: Tue, 17 Sep 2013 07:07:25 -0700
Subject: [PATCH v3] PWM: PXA: add device tree support to PWM driver
In-Reply-To: <52375FB1.5050700@wwwdotorg.org>
References: <1379091281-23662-1-git-send-email-mikedunn@newsguy.com>
 <52375FB1.5050700@wwwdotorg.org>
Message-ID: <5238621D.3050504@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/2013 12:44 PM, Stephen Warren wrote:
> On 09/13/2013 10:54 AM, Mike Dunn wrote:
>> This patch adds device tree support to the PXA's PWM driver.  Only an OF match
>> table is added; nothing needs to be extracted from the device tree node.  The
>> existing ID table is reused for the match table data.
>>
>> Tested on a Palm Treo 680 (both platform data and DT cases).
> 
>> diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> 
>> +- compatible: should be one of:
>> +  - "marvell,pxa250-pwm"
>> +  - "marvell,pxa270-pwm"
>> +  - "marvell,pxa168-pwm"
>> +  - "marvell,pxa910-pwm"
> 
> Not just one of, but possible more than one...


So the phrasing should be "compatible: should be among:" ?


> 
>> diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
> 
>> +		pwm0: pwm at 40b00000 {
>> +			compatible = "marvell,pxa270-pwm";
> 
> I thought the assertion was that pax270 and pxa250 were both compatible?
> If so, that should be:
> 
> 		compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";


Indeed.  Currently, they are all the same.  By that logic, shouldn't it be

compatible = "marvell,pxa250-pwm", "marvell,pxa270-pwm", "marvell,pxa168-pwm",
"marvell,pxa910-pwm";

I am admittedly fuzzy on device tree, but this is starting to seem strange.

Anyway, I'll defer to your judgement and resubmit if you can give me precise
guidance on the above.  Thanks again for the review.

Thanks,
Mike
