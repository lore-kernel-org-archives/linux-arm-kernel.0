From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 17 Oct 2016 09:28:39 +0200
Subject: [PATCH 2/2] ARM: dts: da850: add a node for the LCD controller
In-Reply-To: <65fde145-0820-794d-d345-621f66cdacc0@ti.com>
References: <1475672732-17111-1-git-send-email-bgolaszewski@baylibre.com>
 <1475672732-17111-3-git-send-email-bgolaszewski@baylibre.com>
 <2d276e51-9d37-8648-4aad-283bb2b23626@ti.com>
 <1e23c3e9-d34b-1d8f-8565-c9932a60fd32@ti.com>
 <65fde145-0820-794d-d345-621f66cdacc0@ti.com>
Message-ID: <CAMpxmJXTRZg-BLyT7TBCrfySSaCDVrkEArPpD8cVrAZ4qX0ULQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-10-17 9:12 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
> On Monday 17 October 2016 11:26 AM, Tomi Valkeinen wrote:
>> On 15/10/16 20:42, Sekhar Nori wrote:
>>
>>>> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
>>>> index f79e1b9..32908ae 100644
>>>> --- a/arch/arm/boot/dts/da850.dtsi
>>>> +++ b/arch/arm/boot/dts/da850.dtsi
>>>
>>>> @@ -399,6 +420,14 @@
>>>>                             <&edma0 0 1>;
>>>>                     dma-names = "tx", "rx";
>>>>             };
>>>> +
>>>> +           display: display at 213000 {
>>>> +                   compatible = "ti,am33xx-tilcdc", "ti,da850-tilcdc";
>>>
>>> This should instead be:
>>>
>>> compatible = "ti,da850-tilcdc", "ti,am33xx-tilcdc";
>>>
>>> as the closest match should appear first in the list.
>>
>> Actually I don't think that's correct. The LCDC on da850 is not
>> compatible with the LCDC on AM335x. I think it should be just
>> "ti,da850-tilcdc".
>
> So if "ti,am33xx-tilcdc" is used, the display wont work at all? If thats
> the case, I wonder how the patch passed testing. Bartosz?
>

DA850 uses revision 1 of the IP while am33xx is equipped with rev 2.
The driver reads the appropriate register, detects the revision and
sets the corresponding field in struct tilcdc_drm_private in
tilcdc_load().

Thanks,
Bartosz
