From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 17 Oct 2016 12:42:32 +0530
Subject: [PATCH 2/2] ARM: dts: da850: add a node for the LCD controller
In-Reply-To: <1e23c3e9-d34b-1d8f-8565-c9932a60fd32@ti.com>
References: <1475672732-17111-1-git-send-email-bgolaszewski@baylibre.com>
 <1475672732-17111-3-git-send-email-bgolaszewski@baylibre.com>
 <2d276e51-9d37-8648-4aad-283bb2b23626@ti.com>
 <1e23c3e9-d34b-1d8f-8565-c9932a60fd32@ti.com>
Message-ID: <65fde145-0820-794d-d345-621f66cdacc0@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 October 2016 11:26 AM, Tomi Valkeinen wrote:
> On 15/10/16 20:42, Sekhar Nori wrote:
> 
>>> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
>>> index f79e1b9..32908ae 100644
>>> --- a/arch/arm/boot/dts/da850.dtsi
>>> +++ b/arch/arm/boot/dts/da850.dtsi
>>
>>> @@ -399,6 +420,14 @@
>>>  				<&edma0 0 1>;
>>>  			dma-names = "tx", "rx";
>>>  		};
>>> +
>>> +		display: display at 213000 {
>>> +			compatible = "ti,am33xx-tilcdc", "ti,da850-tilcdc";
>>
>> This should instead be:
>>
>> compatible = "ti,da850-tilcdc", "ti,am33xx-tilcdc";
>>
>> as the closest match should appear first in the list.
> 
> Actually I don't think that's correct. The LCDC on da850 is not
> compatible with the LCDC on AM335x. I think it should be just
> "ti,da850-tilcdc".

So if "ti,am33xx-tilcdc" is used, the display wont work at all? If thats
the case, I wonder how the patch passed testing. Bartosz?

Thanks,
Sekhar
