From: davem@davemloft.net (David Miller)
Date: Tue, 03 Nov 2015 11:34:32 -0500 (EST)
Subject: [PATCH] arcnet/com20020: add LEDS_CLASS dependency
In-Reply-To: <10338405.rWTFsWuIBE@wuerfel>
References: <10338405.rWTFsWuIBE@wuerfel>
Message-ID: <20151103.113432.1400073533179795014.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 03 Nov 2015 14:51:29 +0100

> The newly added led trigger support in the com20020-pci driver causes
> build errors when CONFIG_LEDS_CLASS is disabled:
> 
> drivers/built-in.o: In function `com20020pci_probe':
> (.text+0x185dc4): undefined reference to `devm_led_classdev_register'
> (.text+0x185dd8): undefined reference to `devm_led_classdev_register'
> 
> This adds a Kconfig dependency to prevent the invalid configurations.
> Other drivers appear to be split 50:50 between 'select' and 'depends on'
> for this symbol, I picked 'depends on' as I could not find a common
> policy and it generally causes fewer problems.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 8890624a4e8c ("arcnet: com20020-pci: add led trigger support")

Applied.
