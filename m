From: tony@atomide.com (Tony Lindgren)
Date: Wed, 18 Jul 2018 23:39:43 -0700
Subject: [PATCH v2 2/3 v4] mtd: rawnand: ams-delta: use GPIO lookup table
In-Reply-To: <20180718092041.1d49094a@xps13>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
 <20180717231448.14958-1-jmkrzyszt@gmail.com>
 <20180717231448.14958-3-jmkrzyszt@gmail.com>
 <20180718092041.1d49094a@xps13>
Message-ID: <20180719063943.GH99251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Miquel Raynal <miquel.raynal@bootlin.com> [180718 07:24]:
> Hi Janusz, Tony
> 
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote on Wed, 18 Jul 2018
> 01:14:47 +0200:
> 
> > Now as Amstrad Delta board - the only user of this driver - provides
> > GPIO lookup tables, switch from GPIO numbers to GPIO descriptors and
> > use the table to locate required GPIO pins.
> > 
> > Declare static variables for storing GPIO descriptors and replace
> > gpio_ function calls with their gpiod_ equivalents.
> > 
> > Pin naming used by the driver should be followed while respective GPIO
> > lookup table is initialized by a board init code.
> > 
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > ---
> 
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> As suggested by Boris, we expect this series to go through the OMAP
> tree so we'll need an immutable tag, there are more changes on this
> driver coming in.

Let's wait for v4.19-rc1 to clear the dependencies. I'm not applying
new patches at this point only dealing with the pending pull requests
I have.

Regards,

Tony
