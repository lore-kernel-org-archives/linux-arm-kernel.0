From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 17 Jun 2015 10:00:06 +0200
Subject: [PATCH v5 04/11] nvmem: Add a simple NVMEM framework for consumers
In-Reply-To: <5580A345.30204@codeaurora.org>
References: <1432226535-8640-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1432226593-8817-1-git-send-email-srinivas.kandagatla@linaro.org>
 <5580A345.30204@codeaurora.org>
Message-ID: <20150617080006.GH6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 03:29:25PM -0700, Stephen Boyd wrote:
> On 05/21/2015 09:43 AM, Srinivas Kandagatla wrote:
> > +	/* if it's not end on byte boundary */
> > +	if ((nbits + bit_offset) % BITS_PER_BYTE) {
> > +		/* setup the last byte with msb bits from nvmem */
> > +		rc = regmap_raw_read(nvmem->regmap,
> > +				    cell->offset + cell->bytes - 1, &v, 1);
> > +		*p |= GENMASK(7, (nbits + bit_offset) % BITS_PER_BYTE) & v;
> > +
> > +	}
> > +
> > +	return buf;
> > +}
> > +
> > +/**
> > + * nvmem_cell_write(): Write to a given nvmem cell
> 
> This isn't kernel doc notation. It should be like
> 
>     nvmem_cell_write - Write to a given nvmem cell

Almost. Should be:

      nvmem_cell_write() - Write to a given nvmem cell

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
