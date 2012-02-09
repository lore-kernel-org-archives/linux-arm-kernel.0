From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Feb 2012 14:33:17 +0000
Subject: [PATCH 1/2] ARM: ixp4xx: fix compilation, add gpiolib support
In-Reply-To: <4F33CCD8.6050407@pengutronix.de>
References: <1328729069-21308-1-git-send-email-mkl@blackshift.org>
 <1328729069-21308-2-git-send-email-mkl@blackshift.org>
 <20120209091124.GR889@n2100.arm.linux.org.uk>
 <4F33CCD8.6050407@pengutronix.de>
Message-ID: <20120209143317.GS889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2012 at 02:40:40PM +0100, Marc Kleine-Budde wrote:
> I have to remove the ixp4xx specific gpio_to_irq and irq_to_gpio
> functions or keep the #define gpio_to_irq gpio_to_irq.

Why do you need that?  If your platform specific gpiolib implementation
provides a proper .to_irq method, then it should all work properly.
