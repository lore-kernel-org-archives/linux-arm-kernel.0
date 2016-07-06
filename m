From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 06 Jul 2016 16:56:46 +0200
Subject: [PATCH 13/22] spi: clps711x: Driver refactor
In-Reply-To: <20160606173651.GD7510@sirena.org.uk>
References: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
 <1465024214-22120-14-git-send-email-shc_work@mail.ru>
 <20160606173651.GD7510@sirena.org.uk>
Message-ID: <5228063.5Ux0eYVICa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, June 6, 2016 6:36:51 PM CEST Mark Brown wrote:
> On Sat, Jun 04, 2016 at 10:10:05AM +0300, Alexander Shiyan wrote:
> 
> > +static const struct of_device_id clps711x_spi_dt_ids[] = {
> > +     { .compatible = "cirrus,ep7209-spi", },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, clps711x_spi_dt_ids);
> 
> This adds a new binding but no binding document - all new bindings need
> binding documents.  Other than that it looks fine.

I've written a binding file for that now, and submitted that along
with this patch. Please either pick up both patches into your spi
tree or provide an Ack so I can put them into a branch for arm-soc
along with the other patches.

Linus Walleij has already applied some other patches out of sequence,
so we won't be able to bisect clps711x across the DT conversion, but
I think that's ok now, as the platform is really dead as Alexander
described.

	Arnd
