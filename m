From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Feb 2014 12:02:32 +0000
Subject: [PATCH v2 08/15] mfd: max77836: Add max77836 support to max14577
 driver
In-Reply-To: <1391767487-10017-9-git-send-email-k.kozlowski@samsung.com>
References: <1391767487-10017-1-git-send-email-k.kozlowski@samsung.com>
 <1391767487-10017-9-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20140210120232.GG22773@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Add Maxim 77836 support to max14577 driver. The chipsets have same MUIC
> component so the extcon, charger and regulators are almost the same. The
> max77836 however has also PMIC and Fuel Gauge.
> 
> The MAX77836 uses three I2C slave addresses and has additional interrupts
> (related to PMIC and Fuel Gauge). It has also Interrupt Source register,
> just like MAX77686 and MAX77693.
> 
> The MAX77836 PMIC's TOPSYS and INTSRC interrupts are reported in the
> PMIC block. The PMIC block has different I2C slave address and uses own
> regmap so another regmap_irq_chip is needed.
> 
> Since we have two regmap_irq_chip, use shared interrupts on MAX77836.
> 
> This patch adds additional defines and functions to the max14577 MFD core
> driver so the driver will handle both chipsets. Also this patch replaces
> "0x1 << N" with BIT(N) in defines for register masks.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/mfd/max14577.c               |  217 ++++++++++++++++++++++++++++++++--
>  include/linux/mfd/max14577-private.h |  175 +++++++++++++++++++--------
>  include/linux/mfd/max14577.h         |    7 +-
>  3 files changed, 341 insertions(+), 58 deletions(-)

Much better, thanks.
  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
