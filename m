From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Wed, 11 Nov 2009 18:24:56 +0100
Subject: [PATCH 3/8] omap1: Amstrad Delta defconfig fixes
In-Reply-To: <20091111030057.31793.60438.stgit@localhost>
References: <20091111025907.31793.84134.stgit@localhost>
	<20091111030057.31793.60438.stgit@localhost>
Message-ID: <200911111825.00281.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wednesday 11 November 2009 04:00:57 Tony Lindgren napisa?(a):
> From: Janusz Krzysztofik <jkrzysz@tis.icnet.pl>
>
> The patch provides the following fixes:
>
> - keep kernel small enough to boot with standard tools,
> - ensure compatibility with both new and legacy distros,
> - turn on support for recently added or fixed hardware features.
>
> Created and tested against linux-2.6.32-rc5.
>
> Signed-off-by: Janusz Krzysztofik <jkrzysz@tis.icnet.pl>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Tony,

Please do not apply this patch yet, or revert it if already applied. It would 
exhibit the LCD DMA not working bug when CONFIG_PM=y, as I tried to state 
while submitting v2 of my fix that corrected the issue 
(http://www.spinics.net/lists/linux-omap/msg19963.html).

Sorry for not stating that again with this submission (or not waiting with 
the submission after the bug is fixed first). That happened after I 
misinterpreted your comment "Sounds good to me."  
(http://www.spinics.net/lists/linux-omap/msg19965.html) as your acceptance 
for the patch v2 as posted, with my self proposed changes, that resulted in v3  
submission directly (http://www.spinics.net/lists/linux-omap/msg20059.html), 
that has been objected by you next.

Thanks,
Janusz

> ---
>  arch/arm/configs/ams_delta_defconfig |   24 +++++++++++++++++-------
>  1 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/configs/ams_delta_defconfig
> b/arch/arm/configs/ams_delta_defconfig index 7647325..e8f7380 100644
> --- a/arch/arm/configs/ams_delta_defconfig
> +++ b/arch/arm/configs/ams_delta_defconfig
> @@ -55,10 +55,10 @@ CONFIG_BLK_DEV_INITRD=y
>  CONFIG_INITRAMFS_SOURCE=""
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  CONFIG_SYSCTL=y
> -# CONFIG_EMBEDDED is not set
> +CONFIG_EMBEDDED=y
>  CONFIG_UID16=y
>  CONFIG_SYSCTL_SYSCALL=y
> -CONFIG_KALLSYMS=y
> +# CONFIG_KALLSYMS is not set
>  # CONFIG_KALLSYMS_ALL is not set
>  # CONFIG_KALLSYMS_EXTRA_PASS is not set
>  CONFIG_HOTPLUG=y
> @@ -224,7 +224,7 @@ CONFIG_CPU_CP15_MMU=y
>  #
>  # Processor Features
>  #
> -# CONFIG_ARM_THUMB is not set
> +CONFIG_ARM_THUMB=y
>  # CONFIG_CPU_ICACHE_DISABLE is not set
>  # CONFIG_CPU_DCACHE_DISABLE is not set
>  CONFIG_CPU_DCACHE_WRITETHROUGH=y
> @@ -248,7 +248,7 @@ CONFIG_CPU_DCACHE_WRITETHROUGH=y
>  # CONFIG_HIGH_RES_TIMERS is not set
>  CONFIG_PREEMPT=y
>  CONFIG_HZ=100
> -# CONFIG_AEABI is not set
> +CONFIG_AEABI=y
>  # CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
>  CONFIG_SELECT_MEMORY_MODEL=y
>  CONFIG_FLATMEM_MANUAL=y
> @@ -299,7 +299,9 @@ CONFIG_BINFMT_ELF=y
>  #
>  # Power management options
>  #
> -# CONFIG_PM is not set
> +CONFIG_PM=y
> +# CONFIG_SUSPEND is not set
> +CONFIG_PM_RUNTIME=y
>
>  #
>  # Networking
> @@ -670,7 +672,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
>  CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
>  # CONFIG_INPUT_JOYDEV is not set
>  # CONFIG_INPUT_TSDEV is not set
> -# CONFIG_INPUT_EVDEV is not set
> +CONFIG_INPUT_EVDEV=y
>  # CONFIG_INPUT_EVBUG is not set
>
>  #
> @@ -784,6 +786,7 @@ CONFIG_I2C_OMAP=y
>  #
>  # CONFIG_SPI is not set
>  # CONFIG_SPI_MASTER is not set
> +CONFIG_GPIO_SYSFS=y
>
>  #
>  # Dallas's 1-wire bus
> @@ -820,6 +823,7 @@ CONFIG_LEDS_AMS_DELTA=y
>  CONFIG_LEDS_TRIGGERS=y
>  CONFIG_LEDS_TRIGGER_TIMER=y
>  CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> +CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
>
>  #
>  # Multimedia devices
> @@ -896,7 +900,13 @@ CONFIG_LOGO_LINUX_CLUT224=y
>  #
>  # Sound
>  #
> -# CONFIG_SOUND is not set
> +CONFIG_SOUND=y
> +CONFIG_SND=y
> +CONFIG_SND_MIXER_OSS=y
> +CONFIG_SND_PCM_OSS=y
> +CONFIG_SND_SOC=y
> +CONFIG_SND_OMAP_SOC=y
> +CONFIG_SND_OMAP_SOC_AMS_DELTA=y
>
>  #
>  # HID Devices
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
