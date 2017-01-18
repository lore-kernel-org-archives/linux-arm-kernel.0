From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 18 Jan 2017 14:27:19 -0800
Subject: [PATCH 1/2] ARM64: dts: meson-gxm: Add R-Box Pro
In-Reply-To: <3005a457-b7cf-393b-42ff-4149e080321c@suse.de> ("Andreas
 =?utf-8?Q?F=C3=A4rber=22's?= message of "Wed, 18 Jan 2017 00:06:07 +0100")
References: <20170117030611.23827-1-afaerber@suse.de>
 <20170117030611.23827-2-afaerber@suse.de>
 <3005a457-b7cf-393b-42ff-4149e080321c@suse.de>
Message-ID: <m237ggypfc.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas F?rber <afaerber@suse.de> writes:

> Am 17.01.2017 um 04:06 schrieb Andreas F?rber:
>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>> index 0d7bfbf7d922..66bc809a5eae 100644
>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>> @@ -12,6 +12,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-nexbox-a95x.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-s912-q200.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-s912-q201.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-nexbox-a1.dtb
>
> What is the logic behind meson-gxm-s912-q201 vs. meson-gxm-nexbox-a1?
> Should it be renamed to include -s912 for consistency?

Oops, I think it should be renamed for consistency.

I believe there's only one chip in the GXM family (S912) so it might be
that we could either drop the -s912 from the q20x boards or, add it to
the nexbox.

I lean towards dropping the -s912 since there's a single chip in GXM.
(FWIW, GXL has more than one chip in the family so we added the chip
there.)

>> +dtb-$(CONFIG_ARCH_MESON) += meson-gxm-rbox-pro.dtb
>
> Should this new board use meson-gxm-s912-?

No.  Unless Neil or you thing otherwise, I think we should send a patch
to drop the -s912 from the q20x boards instead.  (where "we" == Neil) ;)

Kevin
