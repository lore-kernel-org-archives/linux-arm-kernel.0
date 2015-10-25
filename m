From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat, 24 Oct 2015 21:48:58 -0600
Subject: [PATCH V2 RFT] ARM: bcm2835: enable all bcm2835-relevant in
 defconfig
In-Reply-To: <1444946250-23219-1-git-send-email-stefan.wahren@i2se.com>
References: <1444946250-23219-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <562C512A.2060805@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2015 03:57 PM, Stefan Wahren wrote:
> Rebuild bcm2835_defconfig using "make bcm2835_defconfig;
> make savedefconfig", and enable manually the following features:
> 
> * all bcm2835-relevant drivers (MBOX, WDT, DMA, PWM, SND)
> * enable regular stackprotector because CONFIG_CC_STACKPROTECTOR
>   disappear
> * enable some new dependencies in order to keep LED heartbeat
>   ( CONFIG_NEW_LEDS, CONFIG_LEDS_CLASS, CONFIG_LEDS_TRIGGERS )

> diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig

> -CONFIG_RESOURCE_COUNTERS=y
> -CONFIG_RD_BZIP2=y
> -CONFIG_RD_LZMA=y
> -CONFIG_RD_XZ=y
> -CONFIG_RD_LZO=y
> -CONFIG_SCSI_MULTI_LUN=y
> -CONFIG_USB_DWC2_HOST=y
> -CONFIG_EXT4_FS=y
> -CONFIG_EXT4_FS_POSIX_ACL=y

Do you know why all of those were removed?
