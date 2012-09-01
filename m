From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 1 Sep 2012 07:11:18 +0000
Subject: [PATCH 3/6] ARM: plat-versatile: add DT support to FPGA IRQ
 controller
In-Reply-To: <CACRpkdamVhbW_nizDODTu2wg7wX+4ENnLMGH=RoHkG4hwn3Yfg@mail.gmail.com>
References: <1345119357-22702-1-git-send-email-linus.walleij@linaro.org>
 <201208161350.49063.arnd@arndb.de>
 <CACRpkdamVhbW_nizDODTu2wg7wX+4ENnLMGH=RoHkG4hwn3Yfg@mail.gmail.com>
Message-ID: <201209010711.18985.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 01 September 2012, Linus Walleij wrote:
> > When all devices get their IRQ numbers from the device
> > tree, you can move to linear IRQ domains instead of legacy, and let
> > the irq domain code pick the numbers.
> 
> It seems I have no other choice here than to move directly to
> linear numbers or atleast dynamically allocated descriptors.

You could also do a hack and keep the number hardcoded, or dependent
on the "compatible" value of the root node, but moving to linear
domains would be nicer because then you don't have to change this code
again.

	Arnd
