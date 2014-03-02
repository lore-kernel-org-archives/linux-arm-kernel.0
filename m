From: tonyho.profession@gmail.com (tonyho)
Date: Sun, 02 Mar 2014 15:57:31 +0800
Subject: [linux-pm] ARM hibernation / suspend-to-disk
In-Reply-To: <20140224215443.9748.65580@capellas-linux>
References: <20130529081005.GA25561@hal> <51A6399D.4090606@ti.com>
 <20140128141458.GD8713@xo-6d-61-c0.localdomain>
 <20140128182245.18840.51279@capellas-linux>
 <loom.20140216T140206-196@post.gmane.org>
 <20140224215443.9748.65580@capellas-linux>
Message-ID: <5312E46B.8020900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian:
You're kind, and thank you firtly.
Now I have try to booting you hibernation_3.13_russMerge branch kernel 
from uboot(Version 2013-10) in BBB, and I don't know how to build the dtb.
I have built the uImage using:
1. make ARCH=arm CROSS_COMPILE=/media/work/BBB/tools/arm-2010.09/bin/arm-
none-linux-gnueabi- omap2plus_defconfig && make ARCH=arm 
CROSS_COMPILE=/media/work/BBB/tools/arm-2010.09/bin/arm-none-linux-gnueabi- 
uImage LOADADDR=0x80008000
2. And I load the uImage using the ext4load from TF card?
(1)ext4load mmc 0:2 80007f00 /boot/uImage
(2)and 'iminfo 0x80007f00' hints image is OK.
(3)The Kernel Command Line is 'init=/linuxrc console=ttyO0,115200n8 
run_hardware_tests root=/dev/mmcblk0p2 ro rootfstype=ext4 rootwait' and 
I select the 'Always use the default kernel command line'
and the configuration has been verified in other version linux kernel 
source code.
(4)But when I 'bootm 80007f00', it just print the 'Starting kernel ...' 
and nothing more. And the USERLED0-3 in BBB are off.
3. I guess this is caused by I haven't load a dts to memory
(1)Can you tell me how to build the dtb? Like 'make XXX.dtb/dts'?
(2)And which dtb should be loaded into memory? What the address should 
be load for the dtb files?

4. I use the busybox to be the rootfs, and it test OK. I prepare add a 
resume command to /sys/power/resume in inittab. Should this work?



On 02/25/2014 05:54 AM, Sebastian Capella wrote:
> Quoting TonyHo (2014-02-16 05:11:47)
>> Hi Sebastian ,Pavel ,Russ:
>>   I want to build the kernelhttps://github.com/russdill/linux/commits/arm-
>> hibernation-am33xx-v3.12 to be used in BeagleBone black too, after I clone
>> and checkout the branch, I'm not sure whether my opration is right, can
>> someone help me to comfirm?
>> Below is my operation:
>> 1. make ARCH=arm CROSS_COMPILE=/media/work/BBB/tools/arm-2010.09/bin/arm-
>> none-linux-gnueabi- omap2plus_defconfig . Is the omap2plus_defconfig is
>> right configuration file?
>> 2. russdill says his board is BeagleBone(http://www.youtube.com/watch?
>> v=3hdbH-Ur-hE), so if there would be some modificaiton to be done before
>> compile this source code?
>> 3. Is there any intructions about using and compiling the hibernation source
>> code?
> Hi Tony,
>
> I use omap2plus_defconfig.
>
> I have been working with BeagleBone Black (bbb) for hibernation on this branch:
>
> http://git.linaro.org/git-ro/people/sebastian.capella/linux.git  hibernation_3.13_russMerge
>
> I ran into a few minor issues on Russ' branch for bbb that I had to work
> around.  In the end it worked fine, but I know I had to add some entries
> in the dts files at least for it to work.
>
> On bbb I'm resuming from initramfs by echoing the hibernation
> swap device onto /sys/power/resume during my initscript, but before
> remounting the partitions.  You may need to do similar.
>
> You will have to change power managemennt -> hibernation to on in
> menuconfig.
>
> I can help more, please let me know what you have and how you'd like to
> set it up.
>
> Thanks!
>
> Sebastian
