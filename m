From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 8 Sep 2010 12:24:54 -0600
Subject: [spi-devel-general] [PATCH] SPI: fix APB pclk power regression
	on U300
In-Reply-To: <AANLkTik+-YwxU7__QnSC8BhEO0-iqAA+u11BBt-2qo9Q@mail.gmail.com>
References: <1282381656-8644-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTik+-YwxU7__QnSC8BhEO0-iqAA+u11BBt-2qo9Q@mail.gmail.com>
Message-ID: <20100908182454.GS3686@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 23, 2010 at 10:30:17AM -0700, Kevin Wells wrote:
> > With the introduction of an AMBA PrimeCell per-cell block clock,
> > the pclk was left on after probe() unless explicitly disabled.
> > This clock is wired to the same clock on PL022 causing it to stay
> > always on since.
> >
> > Fix this up properly by clocking the pclk whenever we want to
> > write into any PL022 registers and clocking the external clock
> > whenever we want to transmit messages on the bus.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> > ---
> > Tested on U300 and U8500, even though the pclk stuff came in from
> > the ARM tree it is probably better to carry this through Grants
> > tree so as not to disturb other patches going in for PL022.
> > ---
> > ?drivers/spi/amba-pl022.c | ? 14 ++++++++------
> > ?1 files changed, 8 insertions(+), 6 deletions(-)
> >
> 
> Tested-by : Kevin Wells <wellsk40@gmail.com>

Applied, thanks.

g.
