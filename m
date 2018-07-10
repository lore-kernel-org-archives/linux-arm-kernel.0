From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 10 Jul 2018 17:30:09 +0200
Subject: [PATCH 2/2] staging: mt7621-gpio: remove driver
In-Reply-To: <20180710151915.2282622-2-arnd@arndb.de>
References: <20180710151915.2282622-1-arnd@arndb.de>
 <20180710151915.2282622-2-arnd@arndb.de>
Message-ID: <20180710153009.GA11605@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 05:18:48PM +0200, Arnd Bergmann wrote:
> The gpio-mt7621 driver has graduated out of staging and got accepted
> into the gpio tree. Since they both use the same Kconfig symbol,
> we could run into conflicts, e.g. I got this failure when the staging
> driver got enabled with the other one being unavailable but using the
> same Kconfig symbol:
> 
> drivers/gpio/gpio-mt7621.c: In function 'mediatek_gpio_bank_probe':
> drivers/gpio/gpio-mt7621.c:228:10: error: 'struct gpio_chip' has no member named 'of_node'
>   rg->chip.of_node = node;
>           ^
> drivers/gpio/gpio-mt7621.c:243:10: error: 'struct gpio_chip' has no member named 'of_gpio_n_cells'
>   rg->chip.of_gpio_n_cells = 2;
>           ^
> drivers/gpio/gpio-mt7621.c:244:10: error: 'struct gpio_chip' has no member named 'of_xlate'
>   rg->chip.of_xlate = mediatek_gpio_xlate;
> 
> It would be trivial to rename the Kconfig symbol to avoid that problem,
> but there is also seems to be little value in keeping the staging driver
> around now.
> 
> Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This is already removed in my staging-next tree and will be in the next
linux-next.

thanks,

greg k-h
