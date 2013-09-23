From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 23 Sep 2013 16:03:48 +0200
Subject: [PATCH] spi: s3c64xx: Add missing compatibles
In-Reply-To: <20130923135042.GH21013@sirena.org.uk>
References: <1379929545-27517-1-git-send-email-m.krawczuk@partner.samsung.com>
 <20130923135042.GH21013@sirena.org.uk>
Message-ID: <1668307.AS5AU6asQx@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Monday 23 of September 2013 14:50:42 Mark Brown wrote:
> On Mon, Sep 23, 2013 at 11:45:45AM +0200, Mateusz Krawczuk wrote:
> > Add compatibles for s3c6410, s5pc100 and s5pc110/s5pv210 boards.
> 
> >  static const struct of_device_id s3c64xx_spi_dt_match[] = {
> > +	{ .compatible = "samsung,s3c2443-spi",
> > +			.data = (void *)&s3c2443_spi_port_config,
> > +	},
> > +	{ .compatible = "samsung,s3c6410-spi",
> > +			.data = (void *)&s3c6410_spi_port_config,
> > +	},
> 
> This is missing s3c6400 and at least one other s3c24xx I think.  They
> can be added later though so applied, thanks.

I think after this patch the table lists all the SoC variants supported
by the driver, at least it's what I can tell from a quick look at
s3c64xx_spi_driver_ids[] array.

The compatible for S3C64xx should be probably called "samsung,s3c6400",
though, as it's the first SoC with this variant.

Best regards,
Tomasz
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130923/df3ed896/attachment.sig>
