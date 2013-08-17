From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 17 Aug 2013 21:12:30 +0200
Subject: [RFC v1 5/5] ARM: mvebu: add board init for Armada 1500
In-Reply-To: <1376682098-10580-6-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376682098-10580-6-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <201308172112.30773.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 August 2013, Sebastian Hesselbarth wrote:
> +config MACH_ARMADA_1500
> +       bool "Marvell Armada 1500 boards"
> +       select ARMADA_1500_CLK
> +       select ARM_GIC
> +       select CACHE_L2X0
> +       select CPU_PJ4B
> +       select DW_APB_TIMER_OF
> +       select LOCAL_TIMERS if SMP
> +       select HAVE_ARM_TWD if LOCAL_TIMERS
> +       select HAVE_SMP
> +       select PINCTRL_ARMADA_1500

Hmm, I also noticed that this enables support for both the Cortex-A9
(using GIC and L2X0) and the PJ4 based variants of Armada 1500. I
wonder if we should have separate options for the two. E.g. if you
want to build a kernel for the Chromecast, there would be no need to
enabled PJ4 support.

I have not been able to find out which core is used in most of the
production Google TV boxes.

	Arnd
