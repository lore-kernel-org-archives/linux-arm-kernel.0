From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 15 Feb 2016 13:11:49 +0000
Subject: arm qemu test failures due to 'driver-core: platform: probe
 of-devices only using list of compatibles'
In-Reply-To: <20160215105909.GH12289@pengutronix.de>
References: <20160214165010.GA3189@roeck-us.net>
 <20160215105909.GH12289@pengutronix.de>
Message-ID: <56C1CE95.6020206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/02/16 10:59, Uwe Kleine-K?nig wrote:
> Hello Guenter,
>
> On Sun, Feb 14, 2016 at 08:50:10AM -0800, Guenter Roeck wrote:
>> Uwe,
>>
>> Your patch 'driver-core: platform: probe of-devices only using list of
>> compatibles' causes the following qemu tests to crash in -next.
>>
>> arm:vexpress-a9:vexpress_defconfig:vexpress-v2p-ca9
>> arm:vexpress-a15:vexpress_defconfig:vexpress-v2p-ca15-tc1
>> arm:vexpress-a9:multi_v7_defconfig:vexpress-v2p-ca9
>> arm:vexpress-a15:multi_v7_defconfig:vexpress-v2p-ca15-tc1
>>
>> Crash log:
>>
>> VFS: Cannot open root device "mmcblk0" or unknown-block(0,0): error -6
>> Please append a correct "root=" boot option; here are the available partitions:
>> 1f00          131072 mtdblock0  (driver?)
>> 1f01           32768 mtdblock1  (driver?)
>> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
>
> Can you provide a complete boot log? This might already reveal which
> device is failing. It might not be the mmci device but something it
> depends on (clock, bus parent, irq).

FWIW the PL180 on my Juno still works fine with this patch picked on top 
of -rc3, so the issue would seem to be something else - From a quick 
comparison between the DTs I see a slight difference in compatible 
strings for the clocks, but the more likely-looking suspect is that the 
VExpress DT references some GPIOs where the Juno DT doesn't.

Robin.

>
> Best regards
> Uwe
>
