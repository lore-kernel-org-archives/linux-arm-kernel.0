From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 7 Jul 2014 23:12:39 +0200
Subject: [PATCH v3] s3cmci: port DMA code to dmaengine API
In-Reply-To: <CA+E=qVeS8DXTz6b9NnVNi4gFufMkf+iUrOU1A0+Ja8ehnBsrhQ@mail.gmail.com>
References: <1401643329-6460-1-git-send-email-anarsoul@gmail.com>
 <CA+E=qVf2QWk+HxPTjwFK8BkD3C+EGbvLDMM4ro1_nYEThe=LtQ@mail.gmail.com>
 <CA+E=qVeS8DXTz6b9NnVNi4gFufMkf+iUrOU1A0+Ja8ehnBsrhQ@mail.gmail.com>
Message-ID: <201407072312.40687.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 July 2014, Vasily Khoruzhick wrote:
> On Mon, Jun 30, 2014 at 10:03 PM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> > On Mon, Jun 23, 2014 at 2:31 PM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> >>
> >> On 1 June 2014 20:22:09 Vasily Khoruzhick wrote:
> >> > Utilise new s3c24xx-dma dmaengine driver for DMA ops.
> >> >
> >> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> >> > ---
> >> > v2: - Don't store async dma descriptor, it's not used
> >> >     - Request DMA channel via dma_request_slave_channel_compat() and use
> >> >       hardcoded DMA channel.
> >> >     - Add dependency on S3C24XX_DMAC (s3cmci uses filter function from it)
> >> > v3: - Use 'depends' instead of 'select' in Kconfig
> >> >     - Drop useless controller registers reads from dma completion callback
> >>
> >> Ping?
> >
> > Ping?
> 
> Could anyone tell me through which tree this patch should be merged?
> I'm pretty sure that I've included everyone from get_maintainer.pl
> output
> except LKML, but no response from maintainer so far.

I think you did everything right, Ulf or Chris should really pick up this
patch. The one thing you could improve is the changeset text which you
wrote as "Utilise new s3c24xx-dma dmaengine driver for DMA ops." What we
really need here is an explanation of why we want this, e.g. what problems
are solved by it etc. I definitely really want this patch as part of 3.17
so we can enabled multiplatform for the platforms that use this driver.

You should also list the

Acked-by: Arnd Bergmann <arnd@arndb.de>

line under your "Signed-off-by" line.

	Arnd
