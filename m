From: broonie@kernel.org (Mark Brown)
Date: Thu, 27 Nov 2014 16:24:59 +0000
Subject: [PATCH 1/4] spi: Add new driver for STMicroelectronics' SPI
 Controller
In-Reply-To: <20141127150508.GI4628@x1>
References: <1417088636-11994-1-git-send-email-lee.jones@linaro.org>
 <1417088636-11994-2-git-send-email-lee.jones@linaro.org>
 <20141127125904.GV7712@sirena.org.uk> <20141127150508.GI4628@x1>
Message-ID: <20141127162459.GY7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 03:05:08PM +0000, Lee Jones wrote:

> > > +		/* Set SSC_CTL to 16 bits-per-word */
> > > +		ctl = readl_relaxed(spi_st->base + SSC_CTL);
> > > +		writel_relaxed((ctl | 0xf), spi_st->base + SSC_CTL);

> > > +		readl_relaxed(spi_st->base + SSC_RBUF);

> > No byte swapping issues here?

> I think this implementation has been pretty heavily tested.  What
> should I be looking out for?

The bytes on the bus should be in exactly the same order as in memory if
the word size is 8, SPI words should be big endian normally.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/23236c2a/attachment.sig>
