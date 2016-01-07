From: broonie@kernel.org (Mark Brown)
Date: Thu, 7 Jan 2016 15:40:24 +0000
Subject: [PATCH v3 1/3] spi: atmel: add support for the internal
 chip-select of the spi controller
In-Reply-To: <yw1xvb771yrl.fsf@unicorn.mansr.com>
References: <cover.1433850255.git.cyrille.pitchen@atmel.com>
 <c05f4d9abfdabb62b3b3cfeb57a3f9c138b4e45d.1433850255.git.cyrille.pitchen@atmel.com>
 <yw1xvb771yrl.fsf@unicorn.mansr.com>
Message-ID: <20160107154024.GF6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2016 at 09:50:54PM +0000, M?ns Rullg?rd wrote:
> Cyrille Pitchen <cyrille.pitchen@atmel.com> writes:

> > +	as->use_cs_gpios = true;
> > +	if (atmel_spi_is_v2(as) &&
> > +	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL)) {
> > +		as->use_cs_gpios = false;
> > +		master->num_chipselect = 4;
> > +	}

> This part breaks the AVR32 boards and probably anything else that
> doesn't use devicetree but does use GPIOs for chip select.

Shouldn't this just be setting defaults for the case where nothing is
provided?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160107/bebfccd1/attachment.sig>
