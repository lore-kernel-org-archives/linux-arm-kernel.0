From: hein_tibosch@yahoo.es (Hein_Tibosch)
Date: Tue, 28 Sep 2010 22:58:41 +0800
Subject: linux-2.6.36-rc4 problems booting rootfs from SD card
In-Reply-To: <201009281716.42122.anarsoul@gmail.com>
References: <20100928130043.000074b1@unknown>
	<201009281716.42122.anarsoul@gmail.com>
Message-ID: <4CA202A1.1040504@yahoo.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 On 28-9-2010 22:16, Vasily Khoruzhick wrote:
> On 28 of September 2010 14:00:43 dylan cristiani wrote:
>> Hi sirs, here is my scenario: kernel 2.6.36-rc4; cpu pxa270; platform
>> is an enhancement (i like to see things that way...) and customisation
>> of the mainstone III board; here comes the (my) problem: if i boot with
>> my standard kernel boot command line (to boot from system flash):
>> 'root=/dev/mtdblock2 rootfstype=jffs2 mem=64M console=ttyS0,115200n8'
>>
>> i can get the rootfs up, and the SD card is up too, and correctly
>> working; here's the relevant kernel log:
>>
>> ....
>> XScale iWMMXt coprocessor detected.
>>  rtc-ds1307 0-0068: setting system clock to 2010-09-28 03:03:08 UTC
>> (1285642988)
>>  pxa27x-udc pxa27x-udc: USB reset
>>  mmc0: new SD card at address aaaa
>>  mmcblk0: mmc0:aaaa SD02G 1.84 GiB
>>   mmcblk0: p1
>>  pxa27x-udc pxa27x-udc: USB reset
>> .....
>>
>> then the rootfs coems up properly.
>>
>> Else, if i try to boot the rootfs directly form the SD card, with
>> kernel boot command line:
>> 'root=/dev/mmcblk0p1 rootfstype=ext2 mem=64M console=ttyS0,115200n8'
>>
>> <cut>
>>  Kernel panic - not syncing: VFS: Unable to mount root fs on
>> unknown-block(0,0)
> It seems you're missing rootdelay=[0-9]+ argument to kernel
I guess the default of rootdelay=1 (sec) should do, no?

Also try the rootwait argument, which goes without parameters:

root=/dev/mmcblk0p1 rootwait rootfstype=ext2 mem=64M console=ttyS0,115200n8

Hein
