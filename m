From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 08 Oct 2012 21:08:49 -0600
Subject: [PATCH 1/6] ARM: bcm476x: Add infrastructure
In-Reply-To: <20121007015405.958959522@gmail.com>
References: <20121007015300.828366635@gmail.com>
 <20121007015405.958959522@gmail.com>
Message-ID: <50739541.2030603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2012 07:53 PM, Domenico Andreoli wrote:
> BCM476x's minimal infrastructure, Kernel's great reuse.

> Index: b/arch/arm/configs/bcm476x_defconfig

> +CONFIG_DEBUG_BCM476X_UART2=y
> +CONFIG_DEBUG_LL_INCLUDE="debug/bcm476x.S"
> +CONFIG_UNCOMPRESS_INCLUDE="debug/bcm476x-uncompress.h"

Was this defconfig file created by "make savedefconfig ; mv defconfig
arch/arm/configs/bcm476x_defconfig"? If you do that, I think those last
two lines I quoted above (and many more) will be removed, since those
values are selected by CONFIG_DEBUG_BCM476X_UART2.
