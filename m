From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 7 Aug 2017 17:39:22 +0200
Subject: [PATCH] ASoC: pxa: don't select SSP for COMPILE_TESTing
In-Reply-To: <20170807104101.3540159-1-arnd@arndb.de>
References: <20170807104101.3540159-1-arnd@arndb.de>
Message-ID: <CAK8P3a3M2RBHq2M4yyOCzMshRhb4GoZdkrvN1tjrek5=2b5cGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 7, 2017 at 12:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> When the audio driver selects CONFIG_PXA_SSP to be a loadable
> module on a platform other than PXA, and the PXA SPI driver
> is built-in, we get a link error in the SPI driver:
>
> drivers/spi/spi-pxa2xx.o: In function `pxa2xx_spi_remove':
> spi-pxa2xx.c:(.text+0x5f0): undefined reference to `pxa_ssp_free'
> drivers/spi/spi-pxa2xx.o: In function `pxa2xx_spi_probe':
> spi-pxa2xx.c:(.text+0xeac): undefined reference to `pxa_ssp_request'
> spi-pxa2xx.c:(.text+0x1468): undefined reference to `pxa_ssp_free'
> spi-pxa2xx.c:(.text+0x15bc): undefined reference to `pxa_ssp_free'
>
> Fixes: 73d7ee2e831f ("ASoC: pxa: add COMPILE_TEST on SND_PXA2XX_SOC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

While trying to write up a better changelog, I found that I had run into this
before and attempted a different fix, see
https://patchwork.kernel.org/patch/8879921/

The commit I referred to in "Fixes:" did not introduce a new problem at
all, but it appears to have made it more likely to run into this situation.

Sending a third patch now, again different.

Mark, let me know if you want something else instead.

       Arnd
