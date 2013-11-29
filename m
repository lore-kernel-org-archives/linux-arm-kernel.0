From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Nov 2013 22:45:16 +0100
Subject: [PATCH v6] gpio: Add MOXA ART GPIO driver
In-Reply-To: <CACRpkda3bEmL+WRX1ct9SoUQOPXOT2mru0uz3-04nZB8G3DsvA@mail.gmail.com>
References: <1381503190-5733-1-git-send-email-jonas.jensen@gmail.com>
 <201311281737.32696.arnd@arndb.de>
 <CACRpkda3bEmL+WRX1ct9SoUQOPXOT2mru0uz3-04nZB8G3DsvA@mail.gmail.com>
Message-ID: <201311292245.16573.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 November 2013, Linus Walleij wrote:
> On Thu, Nov 28, 2013 at 5:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 28 November 2013, Jonas Jensen wrote:
> >> +static void __iomem *moxart_gpio_base;
> >
> > Just one comment: the usual way to do such a driver is to have
> > a derived data structure like
> >
> > struct moxart_gpio_chip {
> >         struct gpio_chip chip;
> >         void __iomem *moxart_gpio_base;
> > };
> >
> > and dynamically allocate that from probe(), using container_of() to
> > get from the gpio_chip pointer to your own structure.
> 
> I see we make this comment a lot.
> 
> On my TODO there is an item to create
> Documentation/driver-model/design-patterns.txt
> 
> And document things like this. And other fun stuff like
> container_of().
> 
> What do you think about this idea?

Great idea!

	Arnd
