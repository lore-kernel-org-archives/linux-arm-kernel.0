From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed, 17 Oct 2012 21:04:22 +1300
Subject: multi_v5_defconfig problem
In-Reply-To: <1350460703.13436.2.camel@gitbox>
References: <1350460703.13436.2.camel@gitbox>
Message-ID: <1350461062.13436.4.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-10-17 at 20:58 +1300, Tony Prisk wrote:
> I tried to prepare a basic multi_v5_defconfig for arch-vt8500 containing
> the following, except that it builds v7 platforms rather than v5.
> 
> I also tried adding CONFIG_ARCH_MULTI_V5 (and CONFIG_ARCH_MULTIPLATFORM)
> but neither made a difference.
> 
> Help please :)
> 
> CONFIG_EXPERIMENTAL=y
> CONFIG_HIGH_RES_TIMERS=y
> CONFIG_ARCH_VT8500=y
> CONFIG_ARM_ARCH_TIMER=y
> CONFIG_AEABI=y
> CONFIG_ARM_APPENDED_DTB=y
> CONFIG_VFP=y
> CONFIG_NET=y
> CONFIG_SERIAL_VT8500=y
> CONFIG_SERIAL_VT8500_CONSOLE=y
> CONFIG_GPIOLIB=y
> CONFIG_GPIO_VT8500=y
> CONFIG_FB=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_FB_VT8500=y
> CONFIG_FB_WM8505=y
> CONFIG_USB=y
> CONFIG_USB_EHCI_HCD=y
> CONFIG_USB_UHCI_HCD=y
> CONFIG_USB_UHCI_PLATFORM=y
> CONFIG_PWM_VT8500=y
> CONFIG_RTC_DRV_VT8500=y
> 
> Regards
> Tony P

Hmph... gave up about a minute too soon.

CONFIG_ARCH_MULTI_V7=n fixes the problem. I assume this is because its
default y and you can't select MULTI_V5 with MULTI_V7.

Regards
Tony P
