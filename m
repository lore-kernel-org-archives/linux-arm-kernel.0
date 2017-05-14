From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 14 May 2017 12:06:39 +0200
Subject: [PATCH v2 02/18] arm64: dts: amlogic: Sort Makefile
In-Reply-To: <2e9efe9b-6bfe-ab69-8811-c85e1a8ec9f9@free.fr>
References: <20170513143337.14278-1-afaerber@suse.de>
 <20170513143337.14278-3-afaerber@suse.de>
 <2e9efe9b-6bfe-ab69-8811-c85e1a8ec9f9@free.fr>
Message-ID: <8632e3d8-6d84-afb9-248e-0fa6de618d58@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 14.05.2017 um 06:28 schrieb Chris Moore:
> Le 13/05/2017 ? 16:33, Andreas F?rber a ?crit :
>> Sort the .dtb files alphabetically to make clear where to add new ones.
>>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>   v1 -> v2:
>>   * Rebased (new boards added)
>>   * Extended commit message
>>     arch/arm64/boot/dts/amlogic/Makefile | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile
>> b/arch/arm64/boot/dts/amlogic/Makefile
>> index b9ad2db7398b..14fa27ccd589 100644
>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>> @@ -7,15 +7,15 @@ dtb-$(CONFIG_ARCH_MESON) +=
>> meson-gxbb-vega-s95-meta.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-telos.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-wetek-hub.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-wetek-play2.dtb
>> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-hwacom-amazetv.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-khadas-vim.dtb
>> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
> 
> s905d should be before s905x if you are imposing alphabetical order.

True, but the above matches the SoC grouping in patch 01/18, and I'd
rather not resend this series more often than necessary. If we need to
respin it, we could insert white lines or comments to make it clearer.
Or Kevin could just add "grouped by SoC" to the commit message. He had
no comment in v1 and wanted to apply them but insisted on a respin.

Regards,
Andreas

>> -dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-hwacom-amazetv.dtb
>> -dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
>> +dtb-$(CONFIG_ARCH_MESON) += meson-gxm-nexbox-a1.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q200.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q201.dtb
>> -dtb-$(CONFIG_ARCH_MESON) += meson-gxm-nexbox-a1.dtb
>>     always        := $(dtb-y)
>>   subdir-y    := $(dts-dirs)

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
