From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 1 Sep 2012 03:14:15 +0200
Subject: [PATCH 3/6] ARM: plat-versatile: add DT support to FPGA IRQ
 controller
In-Reply-To: <201208161350.49063.arnd@arndb.de>
References: <1345119357-22702-1-git-send-email-linus.walleij@linaro.org>
 <201208161350.49063.arnd@arndb.de>
Message-ID: <CACRpkdamVhbW_nizDODTu2wg7wX+4ENnLMGH=RoHkG4hwn3Yfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 3:50 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 16 August 2012, Linus Walleij wrote:
>> +- irq-start: the u32 hardware IRQ number of the first interrupt handled by
>> +  this FPGA IRQ instance - since there may be many FPGA IRQ controller
>> +  instances, each will have its unique hardware offset number.
>
> The irq-start value is a Linux specific invention, the hardware doesn't
> know anything about these. As long as you depend on specific IRQ numbers
> to get assigned, I would use something like auxdata to find the
> start number.

Sorry that does not work. Auxdata is not used with IRQ controllers,
only with devices.

of_irq_init() will dereference the .data field of struct of_device_id
and use as a callback function to initialize the IRQ controller, no
chance to pass any other data that way.

> When all devices get their IRQ numbers from the device
> tree, you can move to linear IRQ domains instead of legacy, and let
> the irq domain code pick the numbers.

It seems I have no other choice here than to move directly to
linear numbers or atleast dynamically allocated descriptors.

Yours,
Linus Walleij
