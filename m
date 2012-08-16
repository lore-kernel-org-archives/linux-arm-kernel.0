From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Aug 2012 13:50:48 +0000
Subject: [PATCH 3/6] ARM: plat-versatile: add DT support to FPGA IRQ
 controller
In-Reply-To: <1345119357-22702-1-git-send-email-linus.walleij@linaro.org>
References: <1345119357-22702-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201208161350.49063.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 August 2012, Linus Walleij wrote:
> +- irq-start: the u32 hardware IRQ number of the first interrupt handled by
> +  this FPGA IRQ instance - since there may be many FPGA IRQ controller
> +  instances, each will have its unique hardware offset number.

The irq-start value is a Linux specific invention, the hardware doesn't
know anything about these. As long as you depend on specific IRQ numbers
to get assigned, I would use something like auxdata to find the
start number. When all devices get their IRQ numbers from the device
tree, you can move to linear IRQ domains instead of legacy, and let
the irq domain code pick the numbers.

	Arnd
