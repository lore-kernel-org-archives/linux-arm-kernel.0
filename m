From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 24 Jun 2013 10:39:49 +0300
Subject: [PATCHv2 10/11] ARM: dts: omap4 clock data
In-Reply-To: <51C3AB46.4040609@codeaurora.org>
References: <1371647942-4811-1-git-send-email-t-kristo@ti.com>
 <1371647942-4811-11-git-send-email-t-kristo@ti.com>
 <51C3AB46.4040609@codeaurora.org>
Message-ID: <51C7F7C5.70201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2013 04:24 AM, Stephen Boyd wrote:
> On 06/19/13 06:19, Tero Kristo wrote:
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index 2a56428..70608db 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -106,6 +106,8 @@
>>   			ti,hwmods = "counter_32k";
>>   		};
>>
>> +		/include/ "omap4-clocks.dtsi"
>> +
>
> Doesn't this cause one platform device to be allocated for each clock
> node defined in omap4-clocks.dtsi? Are you concerned about wasting
> memory on things that aren't really devices and that will never be probed?

Hi Stephen,

Sounds like a valid point to me, so should this include just go under 
the root in omap4.dtsi? I am not quite familiar with DT specifics myself 
as of yet.

-Tero

>
>>   		omap4_pmx_core: pinmux at 4a100040 {
>>   			compatible = "ti,omap4-padconf", "pinctrl-single";
>>   			reg = <0x4a100040 0x0196>;
>
