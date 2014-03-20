From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 20 Mar 2014 18:17:13 +0530
Subject: [PATCH 08/62] ARM: davinci: use explicit 'select' for DA850_EVM
In-Reply-To: <1395257399-359545-9-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-9-git-send-email-arnd@arndb.de>
Message-ID: <532AE351.9000503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 March 2014 12:59 AM, Arnd Bergmann wrote:
> The DAVINCI_DA850_EVM board uses an unusual method to
> enable the GPIO_PCA953X and KEYBOARD_GPIO_POLLED symbols,
> which leads to the dependencies on these symbols being
> ignored. As GPIO_PCA953X actually requires I2C, that
> can lead to build failures when I2C is disabled.
> 
> This patch removes the duplicate symbol definitions

I am okay with this..

> and instead adds equivalent 'select' statements that
> are conditional on the underlying dependencies.

.. but not sure this is needed. The PCA953X was defaulted to y mainly
because the IO expander was used to detect presence of daughter cards.
Even then, I don't think there is any need to force its selection.

> 
> A different question whether we actually want to automatically
> enable them at all or rather put them into defconfig,
> but that should be a separate patch.

It can be enabled through defconfig as you said. I agree that can be a
separate patch. For now, just dropping the replicated Kconfig symbols
should be okay.

Thanks,
Sekhar
