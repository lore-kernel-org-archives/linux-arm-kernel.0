From: broonie@kernel.org (Mark Brown)
Date: Mon, 19 Oct 2015 17:07:16 +0100
Subject: [PATCH] spi-atmel.c: fix DMA for bits_per_word > 8
In-Reply-To: <562513E2.4090303@atmel.com>
References: <CALnQHM3WxNDV3xzJwRfGRVTMYL1mo44VbBb2YawZVUzn0CzFfA@mail.gmail.com>
 <562513E2.4090303@atmel.com>
Message-ID: <20151019160716.GE32054@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 06:01:38PM +0200, Nicolas Ferre wrote:

> > - xfer, &len);
> > + ret = atmel_spi_next_xfer_dma_submit(master, msg,
> > +     xfer, &len);
> >   if (ret) {
> >   dev_err(&spi->dev,
> >   "unable to use DMA, fallback to PIO\n");

> Ok, the patch seems reasonable. So, can you please answer my main
> question and give me the permission to add your "Signed-off-by:" tag or
> re-send me a more standard patch...

> Thanks a lot for your work on this driver David.

Please also remember to CC subsysetm maintainers on patches...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151019/e603fa80/attachment.sig>
