From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Nov 2018 14:48:24 -0600
Subject: [PATCH v2] of/device: Really only set bus DMA mask when
 appropriate
In-Reply-To: <43b231d67abf2dc589af1c3b9d4f01211cda0b89.1541608043.git.robin.murphy@arm.com>
References: <43b231d67abf2dc589af1c3b9d4f01211cda0b89.1541608043.git.robin.murphy@arm.com>
Message-ID: <20181107204824.GA15825@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2018 at 04:30:32PM +0000, Robin Murphy wrote:
> of_dma_configure() was *supposed* to be following the same logic as
> acpi_dma_configure() and only setting bus_dma_mask if some range was
> specified by the firmware. However, it seems that subtlety got lost in
> the process of fitting it into the differently-shaped control flow, and
> as a result the force_dma==true case ends up always setting the bus mask
> to the 32-bit default, which is not what anyone wants.
> 
> Make sure we only touch it if the DT actually said so.
> 
> Fixes: 6c2fb2ea7636 ("of/device: Set bus DMA mask as appropriate")
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Reported-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Tested-by: John Stultz <john.stultz@linaro.org>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Robert Richter <robert.richter@cavium.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
>  v2: Add comment, collect tested-by tags
> 
>  drivers/of/device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

Rob
