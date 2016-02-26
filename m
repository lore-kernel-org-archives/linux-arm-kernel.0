From: plaes@plaes.org (Priit Laes)
Date: Fri, 26 Feb 2016 07:56:55 +0200
Subject: [PATCH RESEND 0/2] spi: sun4i: add DMA support
Message-ID: <1456466217-6793-1-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While trying to get SPI TFT screen working with Cubietruck, I noticed that
at current state driver didn't actually support SPI data bursts bigger than
n bytes (n is probably ~64 bytes).

Patches below were sent to mailinglists a while ago (May 2015) but apparently
were not addressed to correct maintainers and therefore were never applied.

With those patches, it's now possible to use TFT screens over SPI (fbtft
driver in staging), although there seems to be a possible issue where bigger
data bursts cause the driver to temporarily fall back to PIO mode:

spi_master spi32766: Using DMA mode for transfer
spi_master spi32766: Using PIO mode for transfer
spi_master spi32766: Using PIO mode for transfer
spi_master spi32766: Using PIO mode for transfer
spi_master spi32766: Using PIO mode for transfer
spi_master spi32766: Using PIO mode for transfer
spi_master spi32766: Using DMA mode for transfer
spi_master spi32766: Using PIO mode for transfer
spi_master spi32766: Using PIO mode for transfer
spi_master spi32766: Using PIO mode for transfer
spi_master spi32766: Using PIO mode for transfer
spi_master spi32766: Using PIO mode for transfer


Emilio L?pez (1):
  spi: sun4i: add DMA support

Michal Suchanek (1):
  ARM: sunxi: spi: add notice about SPI FIFO limit.

 drivers/spi/spi-sun4i.c | 142 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 130 insertions(+), 12 deletions(-)

-- 
2.7.2
