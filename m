From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 22 Nov 2016 11:30:16 +0100
Subject: [PATCH] ARM: dts: da850: specify max width for display node
In-Reply-To: <77c993f3-1b5f-94cf-c4bc-8a30148e0a4d@ti.com>
References: <1479807775-28283-1-git-send-email-bgolaszewski@baylibre.com>
 <77c993f3-1b5f-94cf-c4bc-8a30148e0a4d@ti.com>
Message-ID: <CAMpxmJXL6rdGOLJ59H9DtNL0-=zk2RQiBtmebdgYV6DrFX2jew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-11-22 11:27 GMT+01:00 Tomi Valkeinen <tomi.valkeinen@ti.com>:
> On 22/11/16 11:42, Bartosz Golaszewski wrote:
>> It has been determined that the highest resolution supported correctly
>> by LCDC rev1 is 800x600 on da850 due to memory bandwidth constraints.
>>
>> Set the max_width property in da850.dtsi to 800.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  arch/arm/boot/dts/da850.dtsi | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
>> index 36066fa..0876238 100644
>> --- a/arch/arm/boot/dts/da850.dtsi
>> +++ b/arch/arm/boot/dts/da850.dtsi
>> @@ -441,6 +441,7 @@
>>                       compatible = "ti,da850-tilcdc";
>>                       reg = <0x213000 0x1000>;
>>                       interrupts = <52>;
>> +                     max-width = <800>;
>>                       status = "disabled";
>>               };
>>       };
>>
>
> Does 1024x768 at 10 work?
>
> The max-width should be the hardware's maximum supported width, not used
> for bandwidth. tilcdc has max-bandwidth property for that.
>
>  Tomi
>

Eeek I misread Jyri's answer.

Will fix that in v2.

Thanks,
Bartosz
