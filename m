From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 30 Jun 2014 22:03:41 +0300
Subject: [PATCH v3] s3cmci: port DMA code to dmaengine API
In-Reply-To: <9001585.uuLFNQ0H0y@anarsoul-thinkpad>
References: <1401643329-6460-1-git-send-email-anarsoul@gmail.com>
 <9001585.uuLFNQ0H0y@anarsoul-thinkpad>
Message-ID: <CA+E=qVf2QWk+HxPTjwFK8BkD3C+EGbvLDMM4ro1_nYEThe=LtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 2:31 PM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> On 1 June 2014 20:22:09 Vasily Khoruzhick wrote:
> > Utilise new s3c24xx-dma dmaengine driver for DMA ops.
> >
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> > v2: - Don't store async dma descriptor, it's not used
> >     - Request DMA channel via dma_request_slave_channel_compat() and use
> >       hardcoded DMA channel.
> >     - Add dependency on S3C24XX_DMAC (s3cmci uses filter function from it)
> > v3: - Use 'depends' instead of 'select' in Kconfig
> >     - Drop useless controller registers reads from dma completion callback
>
> Ping?

Ping?

> >  drivers/mmc/host/Kconfig  |  10 +--
> >  drivers/mmc/host/s3cmci.c | 180
> > +++++++++++++--------------------------------- drivers/mmc/host/s3cmci.h |
> >  4 +-
> >  3 files changed, 52 insertions(+), 142 deletions(-)
