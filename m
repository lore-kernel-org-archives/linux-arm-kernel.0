From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Fri, 24 Jul 2015 18:30:12 +0300
Subject: [PATCH v2 0/2] spi: dw: Reintroduce optional 16 bit data
 register I/O
In-Reply-To: <1435163696-14767-1-git-send-email-michael@smart-africa.com>
References: <1434703435-25198-1-git-send-email-michael@smart-africa.com>
 <1435163696-14767-1-git-send-email-michael@smart-africa.com>
Message-ID: <1437751812.29746.74.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-06-24 at 18:34 +0200, Michael van der Westhuizen wrote:
> The commit dd11444327ce ("spi: dw-spi: Convert 16bit accesses to 
> 32bit
> accesses") globally changed all register access in the dw_apb_ssi 
> driver
> to 32 bit access, which breaks data register (FIFO) access on 
> picoXcell
> platforms.
> 
> This series introduces a boolean to the core spi-dw driver to 
> indicate
> to the core that 16 bit data register access is appropriate, 
> implements
> the code that respects that flag and updates the dw-spi-mmio driver 
> to
> allow setting this boolean from the device tree.
> 
> A binding documentation fix is included in this series.
> 
> Prior to applying this change the following error presents on
> a picoCell pc3x3 platform:
>   spi_master spi32766: interrupt_transfer: fifo overrun/underrun
>   m25p80 spi32766.0: error -5 reading 9f
>   m25p80: probe of spi32766.0 failed with error -5
> 
> With this series applied:
>   m25p80 spi32766.0: m25p40 (512 Kbytes)

Mark, what do you think about this? For me it looks okay.

> 
> Changes in v2:
>   - Incorporate review feedback from Andy Shevchenko, reworking the
>     bindings to reflect common practice and adjusting the driver
>     to suit.
>   - Add a wrapper inline function for accessing the data register
>     using the configured with.
> 
> Michael van der Westhuizen (2):
>   dt: snps,dw-apb-ssi: Document new I/O data register width property
>   spi: dw: Allow interface drivers to limit data I/O to word sizes
> 
>  drivers/spi/spi-dw-mmio.c |  4 ++++
>  drivers/spi/spi-dw.c      |  4 ++--
>  drivers/spi/spi-dw.h      | 35 +++++++++++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+), 2 deletions(-)
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
