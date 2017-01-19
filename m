From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 19 Jan 2017 09:10:02 +0100
Subject: [PATCH 1/2] ARM64: dts: meson-gxm: Add R-Box Pro
In-Reply-To: <m237ggypfc.fsf@baylibre.com>
References: <20170117030611.23827-1-afaerber@suse.de>
 <20170117030611.23827-2-afaerber@suse.de>
 <3005a457-b7cf-393b-42ff-4149e080321c@suse.de> <m237ggypfc.fsf@baylibre.com>
Message-ID: <809182ae-cfb5-7f6f-c383-ee337e78fa4c@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas, Kevin,

On 01/18/2017 11:27 PM, Kevin Hilman wrote:
> Andreas F?rber <afaerber@suse.de> writes:
> 
>> Am 17.01.2017 um 04:06 schrieb Andreas F?rber:
>>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>>> index 0d7bfbf7d922..66bc809a5eae 100644
>>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>>> @@ -12,6 +12,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-nexbox-a95x.dtb
>>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-s912-q200.dtb
>>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-s912-q201.dtb
>>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-nexbox-a1.dtb
>>
>> What is the logic behind meson-gxm-s912-q201 vs. meson-gxm-nexbox-a1?
>> Should it be renamed to include -s912 for consistency?

It followed the GXL logic... until I posted the nexbox-a1 without !
Since the q20x and p23x boards are the same, it was to enforce the fact that
the S912 was on the q200 and q201 boards.

> Oops, I think it should be renamed for consistency.
> 
> I believe there's only one chip in the GXM family (S912) so it might be
> that we could either drop the -s912 from the q20x boards or, add it to
> the nexbox.

I believe this aswell AFAIK.

> 
> I lean towards dropping the -s912 since there's a single chip in GXM.
> (FWIW, GXL has more than one chip in the family so we added the chip
> there.)
> 
>>> +dtb-$(CONFIG_ARCH_MESON) += meson-gxm-rbox-pro.dtb
>>
>> Should this new board use meson-gxm-s912-?
> 
> No.  Unless Neil or you thing otherwise, I think we should send a patch
> to drop the -s912 from the q20x boards instead.  (where "we" == Neil) ;)

Ok, will do.

> 
> Kevin

Neil
