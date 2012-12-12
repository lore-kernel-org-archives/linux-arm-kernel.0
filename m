From: martin@ronetix.at (Martin Peevski)
Date: Wed, 12 Dec 2012 16:01:31 +0200
Subject: Kernel failed to boot when add more drivers
In-Reply-To: <91586D499ADFD74FBCFB8425266A5DE4013765E58576@pluto.melinkcorp.local>
References: <50C881C6.7070806@ronetix.at>
 <91586D499ADFD74FBCFB8425266A5DE4013765E58576@pluto.melinkcorp.local>
Message-ID: <50C88E3B.8090108@ronetix.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/12 15:53, Bryan Evenson wrote:
> Martin,
>
> Whenever I've had similar issues it's because I have a U-Boot environment
> variable that assumes the kernel is smaller than it is.  So U-Boot may not
> be loading the entire kernel which would cause your CRC errors.  Could you
> you provide the following information:
>
> How are you loading the kernel?  From NAND flash, SD card, TFTP boot?

I'm loading the Kernel from NAND

> Could you show us your U-Boot environment variables (result of "printenv"
> U-Boot command)?

U-Boot> printenv
bootargs=mem=128M console=ttyS0,115200 
mtdparts=atmel_nand:8M(bootstrap/uboot/kernel)ro,-(rootfs) 
root=/dev/mtdblock1 rw rootfstype=ubifs ubi.mtd=1 root=ubi0:rootfs
bootcmd=nand read.jffs2 0x22000000 0x200000 0x250000; bootm 0x22000000
bootdelay=1
baudrate=115200
ethact=macb0

Environment size: 277/131067 bytes
U-Boot>


> Thanks,
> Bryan Evenson
>
>
>> -----Original Message-----
>> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
>> kernel-bounces at lists.infradead.org] On Behalf Of Martin Peevski
>> Sent: Wednesday, December 12, 2012 8:08 AM
>> To: linux-arm-kernel at lists.infradead.org
>> Subject: Kernel failed to boot when add more drivers
>>
>>       Hello! Can you, please, help me!
>>
>>       I'm building Linux Kernel version 2.6.39 for at91sam9x5ek. When I
>> want to add more drivers the U-boot is imposible to load the Kernel
>> because CRC error. The size of the uImage is 2.38MB. When I remove some
>> driversand uImage become around 2.31MB the Kernel is loading
>> successfully. Do you know what is the reason, I want to use more
>> drivers?
>>
>>       Many thanks!
>>       Martin Peevski.
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
