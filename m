From: sameo@linux.intel.com (Samuel Ortiz)
Date: Wed, 4 Nov 2015 02:37:14 +0100
Subject: [PATCH] NFC: nfcmrvl: fix SPI driver dependencies
In-Reply-To: <243350307.K4hHIg3V2N@wuerfel>
References: <243350307.K4hHIg3V2N@wuerfel>
Message-ID: <20151104013714.GA4090@zurbaran.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Nov 03, 2015 at 03:03:33PM +0100, Arnd Bergmann wrote:
> The newly added nfcmrvl_spi driver uses the spi_nci
> infrastructure, but does not have a Kconfig dependency on
> that, so we can get a link-time error:
> 
> drivers/built-in.o: In function `nfcmrvl_spi_nci_send':
> (.text+0x1428dc): undefined reference to `nci_spi_send'
> drivers/built-in.o: In function `nfcmrvl_spi_probe':
> (.text+0x142a24): undefined reference to `nci_spi_allocate_spi'
> drivers/built-in.o: In function `nfcmrvl_spi_int_irq_thread_fn':
> (.text+0x142abc): undefined reference to `nci_spi_read'
> 
> This clarifies the dependency.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: caf6e49bf6d0 ("NFC: nfcmrvl: add spi driver")
Applied, thanks.

Cheers,
Samuel.
