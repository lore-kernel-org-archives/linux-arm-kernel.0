From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Nov 2015 22:49:01 +0100
Subject: [PATCH] clocksource: dw_apb_timer_of: support timer-based delay
In-Reply-To: <56372366.6090905@linaro.org>
References: <1446193659-1698-1-git-send-email-jszhang@marvell.com>
 <20151102105113.72aade85@xhacker> <56372366.6090905@linaro.org>
Message-ID: <4138087.gESYTxjr8X@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 November 2015 09:48:38 Daniel Lezcano wrote:
> If I follow the logic of arch_arm_timer is better than dw_apb timer.
> 
> 1. The arch_arm_timer is present
> 
>   => dw_apb timer is not used at all
> 
>   CONFIG_ARM_ARCH_TIMER=y
>   # CONFIG_DW_APB_TIMER is not set
> 
> 2. The arch_arm_timer is *not* present
> 
>   => dw_apb_timer is used with delay code
> 
>   # CONFIG_ARM_ARCH_TIMER is not set
>   CONFIG_DW_APB_TIMER=y
> 
> In both cases, DW_APB_TIMER_BASED_DELAY is not needed.
> 

This still has the same problem that running a multi_v7_defconfig
kernel or a binary distro kernel will always enable both. We really
want to have a good run-time decision, not compile-time.

	Arnd
