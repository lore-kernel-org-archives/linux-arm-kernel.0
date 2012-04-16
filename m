From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 16 Apr 2012 21:11:41 +0200
Subject: [PATCH] Fix asic3 build error
In-Reply-To: <20120414085709.GQ24211@n2100.arm.linux.org.uk>
References: <20120414085709.GQ24211@n2100.arm.linux.org.uk>
Message-ID: <20120416191141.GY24130@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Sat, Apr 14, 2012 at 09:57:09AM +0100, Russell King - ARM Linux wrote:
> OMAP randconfig builds occasionally fail with:
> 
> drivers/mfd/asic3.c: In function 'asic3_gpio_to_irq':
> drivers/mfd/asic3.c:530: error: 'IRQ_BOARD_START' undeclared (first use in this function)
> drivers/mfd/asic3.c:530: error: (Each undeclared identifier is reported only once
> drivers/mfd/asic3.c:530: error: for each function it appears in.)
> 
> Fix it by using asic->irq_base rather than assuming this value is
> IRQ_BOARD_START.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Dmitry Artamonow sent the same fix a few days ago and it's now part of my
for-linus branch.


> ---
> I don't have the ability to do anything but compile test this.  Please
> check that it's correct.  Also, I believe that the check for ASIC3_NUM_GPIOS
> is unnecessary - gpiolib won't call your driver if you don't own the GPIO.
Yes, you're right. __gpio_to_irq() call gpio_to_chip(), so I should only
receive requests for GPIOs I own. I'll fix that up as well.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
