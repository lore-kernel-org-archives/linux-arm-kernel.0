From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 7 Feb 2014 10:48:00 +0000
Subject: [PATCH v2 08/15] mfd: max77836: Add max77836 support to max14577
 driver
In-Reply-To: <1391767487-10017-9-git-send-email-k.kozlowski@samsung.com>
References: <1391767487-10017-1-git-send-email-k.kozlowski@samsung.com>
 <1391767487-10017-9-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20140207104800.GI14727@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 07 Feb 2014, Krzysztof Kozlowski wrote:

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

This should be a Mainatiner's Ack.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
