From: pn@denx.de (Parthiban Nallathambi)
Date: Sun, 1 Jul 2018 20:24:56 +0200
Subject: [PATCH v2 0/3] Add clock driver for Actions S700 SoC
In-Reply-To: <8503ae31-aaf3-e4ba-f385-859a6cd3f8d6@suse.de>
References: <20180626192820.28237-3-sravanhome@gmail.com>
 <20180628191805.3722-1-sravanhome@gmail.com>
 <8503ae31-aaf3-e4ba-f385-859a6cd3f8d6@suse.de>
Message-ID: <440c9eed-b930-5a4c-4320-11eec682add6@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andreas,

On 07/01/2018 08:05 PM, Andreas F?rber wrote:
> Hi Saravannan,
> 
> Am 28.06.2018 um 21:18 schrieb Saravanan Sekar:
>> Changelog v2:
>> Fixed 0 day compilation warning
>> Modified existing dts Actions S900 clock bindings common to Actions
>> Soc family
> 
> Please post v3 without --in-reply-to. It's becoming messy to read.
> 
>> This patchset adds clock support for Actions Semi OWL series S700 SoC
>> with relevant clock bindings and device tree info. 
>>
>> Changed the UART clock using CMU instance and changes are tested in
>> cubieboard7
> 
> Did you find any better way of testing than my "reboot bootloader" from
> preinstalled Android?

Flashing bootloader.bin and u-boot-dtb.img at below offset trigger the
automatic boot from SD. But ADFU needs to long pressed before connecting
the power.

sudo dd if=bootloader.bin of=/dev/sdX bs=512 seek=4097
sudo dd if=u-boot-dtb.img of=/dev/sdX bs=1024 seek=3072

With this is place, u-boot expects GPT layout by default. I am able to boot
the kernel from FAT/ext by updating the bootcmd/u-boot env accordingly. 

I haven't tried flashing/replacing u-boot in eMMC still.

> 
> In addition to missing Actions Semi you may want to CC Cubietech.

+Added cubitech linux group.

> 
> Thanks,
> Andreas
> 

-- 
Thanks,
Parthiban N
