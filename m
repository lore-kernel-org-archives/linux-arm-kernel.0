From: info@lategoodbye.de (Stefan Wahren)
Date: Sun, 25 Oct 2015 09:10:20 +0100
Subject: [PATCH V2 RFT] ARM: bcm2835: enable all bcm2835-relevant in
 defconfig
In-Reply-To: <562C512A.2060805@wwwdotorg.org>
References: <1444946250-23219-1-git-send-email-stefan.wahren@i2se.com>
 <562C512A.2060805@wwwdotorg.org>
Message-ID: <562C8E6C.7030205@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 25.10.2015 um 04:48 schrieb Stephen Warren:
> On 10/15/2015 03:57 PM, Stefan Wahren wrote:
>> Rebuild bcm2835_defconfig using "make bcm2835_defconfig;
>> make savedefconfig", and enable manually the following features:
>>
>> * all bcm2835-relevant drivers (MBOX, WDT, DMA, PWM, SND)
>> * enable regular stackprotector because CONFIG_CC_STACKPROTECTOR
>>    disappear
>> * enable some new dependencies in order to keep LED heartbeat
>>    ( CONFIG_NEW_LEDS, CONFIG_LEDS_CLASS, CONFIG_LEDS_TRIGGERS )
>
>> diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
>
>> -CONFIG_RESOURCE_COUNTERS=y

This option becomes obsolete:

kernel: res_counter: remove the unused API

5b1efc027c0b51ca3e76f4e00c83358f8349f543

>> -CONFIG_RD_BZIP2=y
>> -CONFIG_RD_LZMA=y
>> -CONFIG_RD_XZ=y
>> -CONFIG_RD_LZO=y

These are enabled implicit.

>> -CONFIG_SCSI_MULTI_LUN=y

This option becomes obsolete:

scsi: Remove CONFIG_SCSI_MULTI_LUN

c309b35171ddb5384cc3f2f9dc82a96dccc6b7f6

>> -CONFIG_USB_DWC2_HOST=y
>> -CONFIG_EXT4_FS=y
>> -CONFIG_EXT4_FS_POSIX_ACL=y

These are enabled implicit.

>
> Do you know why all of those were removed?
>
> _______________________________________________
> linux-rpi-kernel mailing list
> linux-rpi-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
>
