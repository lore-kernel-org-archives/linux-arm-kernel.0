From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Wed, 18 Jan 2017 01:27:16 +0100
Subject: [PATCH v4] ARM64: dts: meson-gx: Add reserved memory zone and
 usable memory range
In-Reply-To: <04113569-e342-77ff-f79a-2c9c4dc4c602@suse.de>
References: <1484129414-23325-1-git-send-email-narmstrong@baylibre.com>
 <m21sw66828.fsf@baylibre.com> <d3a00788-c3c1-4b10-90bf-2a8bc6a138f8@suse.de>
 <7fcb8d94-840a-de2c-f43b-9123ccc65514@baylibre.com>
 <CAOesGMhYfhrd-hy=N-FYDEPmumR0=QNzn5xTLxFuKG7apo5qiw@mail.gmail.com>
 <ecb5ff50-f5d5-ffe6-0732-faf5e51906f8@baylibre.com>
 <04113569-e342-77ff-f79a-2c9c4dc4c602@suse.de>
Message-ID: <6bba535f-42bc-3e4b-129b-adc39152cfeb@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 18.01.2017 um 01:00 schrieb Andreas F?rber:
> Am 17.01.2017 um 09:21 schrieb Neil Armstrong:
>> The stress-ng package provides this "stress" command and is used to force the kernel to map more memory
>> zones, but I also got the issue while running a fully fledged Desktop Environment thanks to the
>> recently merged DRM driver.
>> You may not be able to trigger the issue since it seems Amlogic reduces this reserved size on GXL/GXM :
>> https://github.com/khadas/linux/commit/698df2c6cfbb0d1a9359743208e83517b31da6ce
>> But it should be confirmed.
> 
> Confirming no issues on three runs on meson-gxm-rbox-pro:
> 
> boxer:~ # stress-ng --vm 4 --vm-bytes 128M --timeout 10s &
> [1] 2528
> boxer:~ # stress-ng: info:  [2528] dispatching hogs: 4 vm
> stress-ng: info:  [2528] cache allocate: default cache size: 256K
> stress-ng: info:  [2528] successful run completed in 10.07s
> 
> [1]+  Done                    stress-ng --vm 4 --vm-bytes 128M --timeout 10s
> boxer:~ # stress-ng --vm 4 --vm-bytes 128M --timeout 10s
> stress-ng: info:  [2537] dispatching hogs: 4 vm
> stress-ng: info:  [2537] cache allocate: default cache size: 256K
> stress-ng: info:  [2537] successful run completed in 10.07s
> boxer:~ # stress-ng --vm 4 --vm-bytes 128M --timeout 10s
> stress-ng: info:  [2546] dispatching hogs: 4 vm
> stress-ng: info:  [2546] cache allocate: default cache size: 256K
> stress-ng: info:  [2546] successful run completed in 10.07s
> boxer:~ #

Similar results on meson-gxbb-vega-s95-telos (except 512K cache size),
with both mainline EFI and vendor U-Boot.

I notice that I don't have CONFIG_DRM enabled - maybe related?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
