From: david-b@pacbell.net (David Brownell)
Date: Sat, 20 Nov 2010 14:59:28 -0800 (PST)
Subject: [PATCH 6/6] atmel_spi: fix warning In function
	'atmel_spi_dma_map_xfer'
In-Reply-To: <20101120214820.GG8942@pengutronix.de>
Message-ID: <616676.83025.qm@web180301.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



--- On Sat, 11/20/10, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> > +??? ??? void
> *nonconst_tx = (void *)xfer->tx_buf; /* shut up gcc */

Reads like a bad patch to me. Fix the bug,
don't just silence GCC.  Or at least use
a better comment mentioning a constness
cast problems).

- Dave
