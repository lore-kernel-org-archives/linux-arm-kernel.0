From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 9 May 2014 12:24:55 +0100
Subject: [PATCH 04/10] mfd: vexpress: Define the device as MFD cells
In-Reply-To: <1398707877-22596-5-git-send-email-pawel.moll@arm.com>
References: <1398707877-22596-1-git-send-email-pawel.moll@arm.com>
 <1398707877-22596-5-git-send-email-pawel.moll@arm.com>
Message-ID: <20140509112455.GU5767@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Apr 2014, Pawel Moll wrote:

> This patch - finally, after over 6 months! :-( - addresses
> Samuel's request to split the vexpress-sysreg driver into
> smaller portions and define the device in a form of MFD
> cells:
> 
> * LEDs code has been completely removed and replaced with
>   "gpio-leds" nodes in the tree (referencing dedicated
>   GPIO subnodes in sysreg - bindings documentation updated);
>   this also better fits the reality as some variants of the
>   motherboard don't have all the LEDs populated
> 
> * syscfg bridge code has been extracted into a separate
>   driver (placed in drivers/misc for no better place)
> 
> * all the ID & MISC registers are defined as sysconf
>   making them available for other drivers should they need
>   to use them (and also to the user via /sys/kernel/debug/regmap
>   which can be helpful in platform debugging)
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  .../devicetree/bindings/arm/vexpress-sysreg.txt    |  36 +-
>  arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            |  76 ++-
>  arch/arm/boot/dts/vexpress-v2m.dtsi                |  76 ++-
>  arch/arm/mach-vexpress/ct-ca9x4.c                  |   2 +-
>  arch/arm/mach-vexpress/v2m.c                       |  15 +-
>  drivers/mfd/Kconfig                                |  15 +-
>  drivers/mfd/Makefile                               |   2 +-
>  drivers/mfd/vexpress-sysreg.c                      | 533 ++++++---------------
>  drivers/misc/Kconfig                               |   9 +
>  drivers/misc/Makefile                              |   1 +
>  drivers/misc/vexpress-syscfg.c                     | 324 +++++++++++++
>  include/linux/vexpress.h                           |  16 +-
>  12 files changed, 667 insertions(+), 438 deletions(-)
>  create mode 100644 drivers/misc/vexpress-syscfg.c

MFD changes look reasonable to me, and remove a hell of a lot of code.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
