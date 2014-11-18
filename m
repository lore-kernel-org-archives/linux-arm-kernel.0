From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 18 Nov 2014 13:55:05 +0300
Subject: [PATCH] ARM: dts: DRA7: Add node for RTC
In-Reply-To: <546AD290.8080303@ti.com>
References: <1416199509-3977-1-git-send-email-lokeshvutla@ti.com>
 <5469E76A.7020105@cogentembedded.com> <5469F271.9080102@ti.com>
 <546A1E5E.1040909@cogentembedded.com> <546AD290.8080303@ti.com>
Message-ID: <546B2589.1090504@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/18/2014 8:01 AM, Lokesh Vutla wrote:

>>>>> Add node for RTC.

>>>>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>>>>> [nm at ti.com: update with rtc crossbar number]
>>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>>> ---
>>>>>     arch/arm/boot/dts/dra7.dtsi | 9 +++++++++
>>>>>     1 file changed, 9 insertions(+)

>>>>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>>>>> index 9cc9843..f98f9f0 100644
>>>>> --- a/arch/arm/boot/dts/dra7.dtsi
>>>>> +++ b/arch/arm/boot/dts/dra7.dtsi
>>>>> @@ -1075,6 +1075,15 @@
>>>>>                 status = "disabled";
>>>>>             };
>>>>>
>>>>> +        rtc: rtcss at 48838000 {

>>>>      Please just name the node "rtc at 48838000", in accordance with ePAPR.

>>> Okay. will update it.

>>>>> +            compatible = "ti,am3352-rtc";
>>>>> +            reg = <0x48838000 0x100>;
>>>>> +            interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>;

>>>>      2 similar interrupts?

>>> both rtc timer and rtc alarm uses same interrupt on DRA7 Soc.
>>> Driver handles it accordingly.
>>> So passing the same interrupt.

>>     I think it would have been better if the driver just handled a single interrupt.

> There are certain SoCs with RTC IP where timer and alarm uses different interrupts.

    I understood.

> Driver has to take care of that scenario also. So it expects two interrupts from dt.

    You could also handle the missing second interrupt. I don't insist though...

> Thanks and regards,
> Lokesh

WBR, Sergei
