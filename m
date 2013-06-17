From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 17 Jun 2013 21:36:44 +0200
Subject: [RFC PATCH 09/11] spi: s3c64xx: Do not require legacy DMA API in
 case of S3C64XX
In-Reply-To: <20130617160630.GF1403@sirena.org.uk>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <CACRpkdb8V7pYVnOWOAJ6iG8_-jyeutq5W95+OCO4RLOv9EDjyg@mail.gmail.com>
 <20130617160630.GF1403@sirena.org.uk>
Message-ID: <6736155.CBigTcsD4z@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 of June 2013 17:06:30 Mark Brown wrote:
> On Mon, Jun 17, 2013 at 03:59:39PM +0200, Linus Walleij wrote:
> > On Sun, Jun 16, 2013 at 10:54 PM, Tomasz Figa <tomasz.figa@gmail.com> 
wrote:
> > > -       select S3C64XX_DMA if ARCH_S3C64XX
> > > +       select S3C64XX_DMA if ARCH_S3C64XX && !S3C64XX_PL080
> > 
> > I guess this means the SPI driver does not work without DMA.
> > But is the SPI driver already augmented to handle generic DMA engine?
> 
> > Anyway:
> Yes, the driver currently relies on DMA.  There are some pending patches
> for non-DMA operation that I need to test.  To be honest for both this
> and the ASoC driver I'd be more inclined to just either select or
> depend on the DMA controller rather than leaving the option of using
> the old code.

Well, I just left this for the purpose of this RFC, so testing things on 
both drivers would be possible (to see if any problems are caused by new 
driver or just by things that don't work).

If this driver turns out to be working correctly, I will happily remove 
the old private one and after s3c24xx moves to Heiko's DMA engine driver 
(or as it already moved?) we will be able to completely drop the private 
s3c-dma API.

Best regards,
Tomasz
