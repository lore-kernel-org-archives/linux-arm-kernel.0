From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 07 Feb 2014 11:54:02 +0100
Subject: [PATCH v2 08/15] mfd: max77836: Add max77836 support to max14577
 driver
In-Reply-To: <20140207104912.GJ14727@lee--X1>
References: <1391767487-10017-1-git-send-email-k.kozlowski@samsung.com>
 <1391767487-10017-9-git-send-email-k.kozlowski@samsung.com>
 <20140207104912.GJ14727@lee--X1>
Message-ID: <1391770442.12119.4.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-02-07 at 10:49 +0000, Lee Jones wrote:
> > Add Maxim 77836 support to max14577 driver. The chipsets have same MUIC
> > component so the extcon, charger and regulators are almost the same. The
> > max77836 however has also PMIC and Fuel Gauge.
> > 
> > The MAX77836 uses three I2C slave addresses and has additional interrupts
> > (related to PMIC and Fuel Gauge). It has also Interrupt Source register,
> > just like MAX77686 and MAX77693.
> > 
> > The MAX77836 PMIC's TOPSYS and INTSRC interrupts are reported in the
> > PMIC block. The PMIC block has different I2C slave address and uses own
> > regmap so another regmap_irq_chip is needed.
> > 
> > Since we have two regmap_irq_chip, use shared interrupts on MAX77836.
> > 
> > This patch adds additional defines and functions to the max14577 MFD core
> > driver so the driver will handle both chipsets. Also this patch replaces
> > "0x1 << N" with BIT(N) in defines for register masks.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> My Ack is missing from this patch too.
> 
> ... and probably all the others? How will I know which ones I've
> already Acked without reviewing them all again?

I already added your ACK-s to patches which got them. Unfortunately the
numbering of patches changed because 4 of them were applied and 1 was
dropped.

This particular patch (previously: 13/18) haven't got you ACK because
you've pointed some issues to fix.

Best regards,
Krzysztof
