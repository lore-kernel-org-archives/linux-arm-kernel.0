From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 14 Nov 2014 18:28:12 +0100
Subject: [PATCH v7 03/13] ARM: Berlin: select the reset controller
In-Reply-To: <54662192.6000403@gmail.com>
References: <1415978763-27345-1-git-send-email-antoine.tenart@free-electrons.com>
 <1415978763-27345-4-git-send-email-antoine.tenart@free-electrons.com>
 <3287202.nx0cnO5WUI@wuerfel> <54662192.6000403@gmail.com>
Message-ID: <20141114172812.GD2991@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Fri, Nov 14, 2014 at 04:36:50PM +0100, Sebastian Hesselbarth wrote:
> On 11/14/2014 04:33 PM, Arnd Bergmann wrote:
> >On Friday 14 November 2014 16:25:53 Antoine Tenart wrote:
> >>  menuconfig ARCH_BERLIN
> >>         bool "Marvell Berlin SoCs" if ARCH_MULTI_V7
> >>+       select ARCH_HAS_RESET_CONTROLLER
> >>         select ARCH_REQUIRE_GPIOLIB
> >>         select ARM_GIC
> >>         select GENERIC_IRQ_CHIP
> >>         select DW_APB_ICTL
> >>         select DW_APB_TIMER_OF
> >>         select PINCTRL
> >>+       select RESET_CONTROLLER
> >
> >RESET_CONTROLLER is meant to be user-selectable, don't add a 'select' here,
> >but instead make the driver 'depends on RESET_CONTROLLER'.
> 
> It already went into arm-soc for v3.19 - ergo, we need an extra
> patch for removing the current 'select'.

Do you want me to send the extra patch fixing this issue?

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
