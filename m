From: broonie@kernel.org (Mark Brown)
Date: Mon, 17 Jun 2013 17:06:30 +0100
Subject: [RFC PATCH 09/11] spi: s3c64xx: Do not require legacy DMA API in
 case of S3C64XX
In-Reply-To: <CACRpkdb8V7pYVnOWOAJ6iG8_-jyeutq5W95+OCO4RLOv9EDjyg@mail.gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <1371416058-22047-10-git-send-email-tomasz.figa@gmail.com>
 <CACRpkdb8V7pYVnOWOAJ6iG8_-jyeutq5W95+OCO4RLOv9EDjyg@mail.gmail.com>
Message-ID: <20130617160630.GF1403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 03:59:39PM +0200, Linus Walleij wrote:
> On Sun, Jun 16, 2013 at 10:54 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> > -       select S3C64XX_DMA if ARCH_S3C64XX
> > +       select S3C64XX_DMA if ARCH_S3C64XX && !S3C64XX_PL080

> I guess this means the SPI driver does not work without DMA.
> But is the SPI driver already augmented to handle generic DMA engine?
> Anyway:

Yes, the driver currently relies on DMA.  There are some pending patches
for non-DMA operation that I need to test.  To be honest for both this
and the ASoC driver I'd be more inclined to just either select or depend
on the DMA controller rather than leaving the option of using the old
code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130617/12639d9a/attachment.sig>
