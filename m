From: Barry.Song@csr.com (Barry Song)
Date: Thu, 9 Feb 2012 03:38:15 +0000
Subject: [PATCH v3] SPI: add CSR SiRFprimaII SPI controller driver
In-Reply-To: <20120208162639.GJ15647@game.jcrosoft.org>
References: <1328717446-4526-1-git-send-email-21cnbao@gmail.com>
 <20120208162639.GJ15647@game.jcrosoft.org>
Message-ID: <5EB3BFCD089AD643B9BB63439F5FD5E99CB90C53@SHAASIEXM01.ASIA.ROOT.PRI>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Jean-Christophe PLAGNIOL-VILLARD [mailto:plagnioj at jcrosoft.com]
> Sent: Thursday, February 09, 2012 12:27 AM
> To: Barry Song
> Cc: grant.likely at secretlab.ca; spi-devel-general at lists.sourceforge.net; Barry
> Song; linux-arm-kernel at lists.infradead.org; DL-SHA-WorkGroupLinux; Zhiwu
> Song
> Subject: Re: [PATCH v3] SPI: add CSR SiRFprimaII SPI controller driver
> 
>  +
> > +static int spi_sirfsoc_setup(struct spi_device *spi)
> > +{
> > +	struct spi_bitbang *bitbang;
> > +	struct sirfsoc_spi *sspi;
> > +
> > +	if (!spi->max_speed_hz)
> > +		return -EINVAL;
> > +
> > +	sspi = spi_master_get_devdata(spi->master);
> > +	bitbang = &sspi->bitbang;
> why do you need this?

Jean, thanks! it is redundant code which misses cleanup. I'd like to wait whether Grant has more feedback and fix those together with this one.

> > +
> > +	if (!spi->bits_per_word)
> > +		spi->bits_per_word = 8;
> > +
> > +	return spi_sirfsoc_setup_transfer(spi, NULL);
> > +}
> 
> Best Regards,
> J.

-barry



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
