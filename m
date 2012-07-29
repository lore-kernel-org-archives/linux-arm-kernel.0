From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 29 Jul 2012 14:19:52 +0000
Subject: Sharing resources between several drivers.
In-Reply-To: <CACKLOr2enmsVqQnJ8JZJJd3z3gGKDKwj74PnWKEk6SwSN=ZoJw@mail.gmail.com>
References: <CACKLOr2enmsVqQnJ8JZJJd3z3gGKDKwj74PnWKEk6SwSN=ZoJw@mail.gmail.com>
Message-ID: <201207291419.52526.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 July 2012, javier Martin wrote:
> we are trying to support pinctrl for i.MX21, i.MX1 and i.MX27.
> 
> In these chips, gpio and pinctrl use the same HW memory area
> registers. This means that we have to request the same memory area
> from two different drivers (gpio and pinctrl) but we don't know how to
> do that.
> 
> A similar example available is mxs, but it only works with device
> tree, so this problem is avoided.  However, some of these chips
> (i.MX21, i.MX1...) don't support device tree yet, so we need to
> provide backwards compatibility.
> 
> What is the right way to request the same memory region from two
> different drivers? Moreover, how can we guarantee that there won't be
> any conflicts when accessing these shared resources?

I think the method that Linus Walleij usually recomments for dealing with
this is to create a combined gpio+pinctrl driver that lives in
drivers/pinctrl but registers to gpiolib as well.

Have a look at drivers/pinctrl/pinctrl-nomadik.c for an example of this.

	Arnd
