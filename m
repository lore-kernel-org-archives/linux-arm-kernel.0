From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 15 Jan 2017 15:43:15 +0100
Subject: [PATCH v4] ARM64: dts: meson-gx: Add reserved memory zone and
 usable memory range
In-Reply-To: <m21sw66828.fsf@baylibre.com>
References: <1484129414-23325-1-git-send-email-narmstrong@baylibre.com>
 <m21sw66828.fsf@baylibre.com>
Message-ID: <d3a00788-c3c1-4b10-90bf-2a8bc6a138f8@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 13.01.2017 um 21:03 schrieb Kevin Hilman:
> Neil Armstrong <narmstrong@baylibre.com> writes:
> 
>> The Amlogic Meson GXBB/GXL/GXM secure monitor uses part of the memory space,
>> this patch adds this reserved zone and redefines the usable memory range.
>>
>> The memory node is also moved from the dtsi files into the proper dts files
>> to handle variants memory sizes.
>>
>> This patch also fixes the memory sizes for the following platforms :
>> - gxl-s905x-p212 : 1GiB instead of 2GiB, a proper 2GiB dts should be pushed
>> - gxm-s912-q201 : 1GiB instead of 2GiB, a proper 2GiB dts should be pushed
>> - gxl-s905d-p231 : 1GiB instead of 2GiB, a proper 2GiB dts should be pushed
>> - gxl-nexbox-a95x : 1GiB instead of 2GiB, a proper 2GiB dts should be pushed
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> Queued for v4.10-rc.

What is the motivation for this change? I have a local U-Boot patch to
detect the amount of memory available as done downstream, but U-Boot
only updates the reg property that you seem to be abandoning here...

So for devices that come in multiple RAM configurations - like R-Box Pro
- this would require separate .dts files now! This looks very wrong to
me, especially since I am not aware of other platforms doing the same.
Instead, there's memory reservations for top and bottom done in U-Boot
for reg, plus reserved-memory nodes for anything in the middle.

Another thing to consider is that uEFI boot (bootefi) handles memory
reservation differently yet again, on the bootloader level. I have had
that working fine on Odroid-C2 and Vega S95.

So if there's no bug this is fixing (none mentioned in commit message) I
strongly object to this patch.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
