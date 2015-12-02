From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 1 Dec 2015 21:17:53 -0700
Subject: [PATCH V3 RFT] ARM: bcm2835: enable all bcm2835-relevant in
 defconfig
In-Reply-To: <1445969338-23977-1-git-send-email-stefan.wahren@i2se.com>
References: <1445969338-23977-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <565E70F1.7010103@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2015 12:08 PM, Stefan Wahren wrote:
> Rebuild bcm2835_defconfig using "make bcm2835_defconfig;
> make savedefconfig", and enable manually the following features:
> 
> * all bcm2835-relevant drivers (MBOX, WDT, DMA, PWM, SND)
> * enable regular stackprotector because CONFIG_CC_STACKPROTECTOR
>   disappear
> * enable some new dependencies in order to keep LED heartbeat
>   ( CONFIG_NEW_LEDS, CONFIG_LEDS_CLASS, CONFIG_LEDS_TRIGGERS )
> 
> The following options were removed, because they are enabled implicit:
> 
> CONFIG_RD_BZIP2, CONFIG_RD_LZMA, CONFIG_RD_XZ, CONFIG_RD_LZO,
> CONFIG_USB_DWC2_HOST, CONFIG_EXT4_FS, CONFIG_EXT4_FS_POSIX_ACL
> 
> These options became obsolete:
> 
> CONFIG_RESOURCE_COUNTERS, CONFIG_SCSI_MULTI_LUN

This all sounds plausible, although I haven't had time to test. Perhaps
some other RPi maintainer can.

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
