From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Nov 2014 16:33:27 +0100
Subject: [PATCH v7 03/13] ARM: Berlin: select the reset controller
In-Reply-To: <1415978763-27345-4-git-send-email-antoine.tenart@free-electrons.com>
References: <1415978763-27345-1-git-send-email-antoine.tenart@free-electrons.com>
 <1415978763-27345-4-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <3287202.nx0cnO5WUI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 November 2014 16:25:53 Antoine Tenart wrote:
>  menuconfig ARCH_BERLIN
>         bool "Marvell Berlin SoCs" if ARCH_MULTI_V7
> +       select ARCH_HAS_RESET_CONTROLLER
>         select ARCH_REQUIRE_GPIOLIB
>         select ARM_GIC
>         select GENERIC_IRQ_CHIP
>         select DW_APB_ICTL
>         select DW_APB_TIMER_OF
>         select PINCTRL
> +       select RESET_CONTROLLER

RESET_CONTROLLER is meant to be user-selectable, don't add a 'select' here,
but instead make the driver 'depends on RESET_CONTROLLER'.

	Arnd
