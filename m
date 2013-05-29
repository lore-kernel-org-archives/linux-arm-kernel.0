From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 May 2013 09:56 +0200
Subject: [PATCH] SPI: Unify simple platform data for some controllers
In-Reply-To: <1369809742-4220-1-git-send-email-shc_work@mail.ru>
References: <1369809742-4220-1-git-send-email-shc_work@mail.ru>
Message-ID: <1743419.NY2Q01i8Iq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 May 2013 10:42:22 Alexander Shiyan wrote:
> This patch unifies simple pdata for some SPI controllers where only
> array of GPIOs is used for define chipselects.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Wouldn't it be better to kill off the platform_data for these drivers
and pass the gpio number through spi->controller_data as the
spi_gpio driver does?

	Arnd
