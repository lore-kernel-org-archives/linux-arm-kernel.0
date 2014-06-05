From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 05 Jun 2014 15:29:21 +0200
Subject: [alsa-devel] [PATCH 1/2] [RFC] ASoC: samsung: move s3c24xx over
 to dmaengine
In-Reply-To: <6123933.aGtaUr149J@wuerfel>
References: <6123933.aGtaUr149J@wuerfel>
Message-ID: <539070B1.8070404@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2014 03:20 PM, Arnd Bergmann wrote:
> The s3c24xx sound support keeps giving randconfig build errors, this
> is a new attempt to solve it by moving the driver over to use dmaengine
> exclusively.
>
> The removal of the legacy DMA support and the addition of the
> s3c24xx_dma_filter pointer are fairly obvious here. The part I'm not
> completely sure about is the removal of the s3c2410_dma_ctrl(...,
> S3C2410_DMAOP_STARTED) and dma_data->ops->started() calls. My understanding
> is that these are only required for drivers that do not support cyclic
> transfers, which the new dma engine driver now does, so we can simply
> remove them. This would also fix at least one bug in the ac97 driver
> on newer machines, which currently gives us a NULL pointer dereference
> from trying to call dma_data->ops->started().
>
> Any insights about this, or testing would be very welcome.
>

There is already a very similar patch for this, see:
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-June/077327.html

I think that one is scheduled to be merged.

- Lars
