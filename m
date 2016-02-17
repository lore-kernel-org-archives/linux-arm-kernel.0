From: davem@davemloft.net (David Miller)
Date: Tue, 16 Feb 2016 20:36:13 -0500 (EST)
Subject: [PATCH] net: phy: spi_ks8995: include linux/gpio/consumer.h
In-Reply-To: <1455273762-161477-1-git-send-email-arnd@arndb.de>
References: <1455273762-161477-1-git-send-email-arnd@arndb.de>
Message-ID: <20160216.203613.1959933915599102205.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 12 Feb 2016 11:42:34 +0100

> The ks8995 phy driver just started using gpiod_* functions, which are
> declared in linux/gpio/consumer.h, not linux/gpio.h, resulting in a
> build failure in randconfig builds that do not have CONFIG_GPIOLIB
> enabled:
> 
> drivers/net/phy/spi_ks8995.c: In function 'ks8995_probe':
> drivers/net/phy/spi_ks8995.c:477:3: error: implicit declaration of function 'gpiod_set_value' [-Werror=implicit-function-declaration]
> 
> This changes the header inclusion so it builds in all configurations.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: cd6f288cbaab ("net: phy: spi_ks8995: add support for resetting switch using GPIO")

Applied, thanks Arnd.
