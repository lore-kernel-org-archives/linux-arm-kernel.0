From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 22 Mar 2011 14:28:55 +0000
Subject: [PATCH] Input: tca6416-keypad: Change to module_init()
In-Reply-To: <20110322142619.1109.89105.sendpatchset@t400s>
References: <20110322142619.1109.89105.sendpatchset@t400s>
Message-ID: <20110322142855.GB2202@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2011 at 11:26:19PM +0900, Magnus Damm wrote:

> The tca6416 driver makes use of the I2C bus for chatting
> with the actual hardware device. Without this patch both
> the I2C bus driver and the tca6416 driver are initialized
> at the subsys_initcall() level. This may lead to problems
> with the tca6416 driver being initialized before the I2C
> bus driver.

While this change seems reasonable I'm curious what the problems caused
by out of order registration are?
