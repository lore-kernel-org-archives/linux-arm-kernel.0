From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 22 Sep 2012 13:58:18 +0100
Subject: [PATCH] ARM: pxa2xx: Remove EXPERIMENTAL dependency from
 spi-pxa2xx driver
In-Reply-To: <505DB50C.4050206@yahoo.com>
References: <505DB50C.4050206@yahoo.com>
Message-ID: <20120922125818.GK15609@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 22, 2012 at 01:54:36PM +0100, Paul Parsons wrote:
> The SPI_PXA2XX config option has had an EXPERIMENTAL dependency since it
> was first added in 2006. Since there seem to have been no changes to the
> spi-pxa2xx driver since February 2011 other than tree sweeps, this patch
> removes the EXPERIMENTAL dependency in the expectation that the
> spi-pxa2xx driver is now stable.
>
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> ---
>
> The motivation for this patch was to remove the EXPERIMENTAL option from
> the hx4700 platform config: SPI_PXA2XX is the only option which is still
> EXPERIMENTAL.
>
>  drivers/spi/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 5f84b55..357be93 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -284,7 +284,7 @@ config SPI_PPC4xx
>
>  config SPI_PXA2XX
>  	tristate "PXA2xx SSP SPI master"
> -	depends on (ARCH_PXA || (X86_32 && PCI)) && EXPERIMENTAL
> +	depends on (ARCH_PXA || (X86_32 && PCI))

Please also remove the parens which then become unnecessary after this
change.
