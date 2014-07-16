From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 16 Jul 2014 14:58:03 +0200
Subject: [PATCH 18/19] ARM: SAMSUNG: Remove remaining legacy code
In-Reply-To: <1405505756.4408.24.camel@x220>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
 <1404496099-26708-19-git-send-email-t.figa@samsung.com>
 <1405505756.4408.24.camel@x220>
Message-ID: <53C676DB.6070002@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.07.2014 12:15, Paul Bolle wrote:
> On Fri, 2014-07-04 at 19:48 +0200, Tomasz Figa wrote:

[snip]

>> -config PLAT_S5P
>> -	bool
>> -	depends on ARCH_S5PV210
>> -	default y
>> -	select ARCH_REQUIRE_GPIOLIB
>> -	select ARM_VIC
>> -	select NO_IOPORT_MAP
>> -	select PLAT_SAMSUNG
>> -	select S3C_GPIO_TRACK
>> -	select S5P_GPIO_DRVSTR
>> -	help
>> -	  Base platform code for Samsung's S5P series SoC.
>> -
> 
> After this patch that symbol is still referenced in:
> drivers/media/platform/Kconfig:159:     depends on VIDEO_DEV && VIDEO_V4L2 && (PLAT_S5P || ARCH_EXYNOS)
> drivers/media/platform/Kconfig:169:     depends on VIDEO_DEV && VIDEO_V4L2 && (PLAT_S5P || ARCH_EXYNOS)
> drivers/media/platform/Kconfig:177:     depends on VIDEO_DEV && VIDEO_V4L2 && (PLAT_S5P || ARCH_EXYNOS)
> drivers/media/platform/exynos4-is/Kconfig:5:    depends on (PLAT_S5P || ARCH_EXYNOS)
> drivers/media/platform/s5p-tv/Kconfig:11:       depends on (PLAT_S5P || ARCH_EXYNOS) && PM_RUNTIME
> drivers/usb/host/Kconfig:223:       depends on PLAT_S5P || ARCH_EXYNOS
> drivers/usb/host/Kconfig:530:   depends on PLAT_S5P || ARCH_EXYNOS
> 
> Again, I assume patches to remove these references are pending. But is
> that correct?

I had two patches fixing those, but apparently this was lost in action.
The correct solution is s/PLAT_S5P/ARCH_S5PV210/. I will include this in
a follow-up series if nobody objects.

Best regards,
Tomasz
