From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Thu, 19 Jul 2018 08:47:49 +0200
Subject: [RFC PATCH 8/8] mtd: rawnand: ams-delta: Use GPIO callbacks for
 data I/O
In-Reply-To: <20180718235710.18242-9-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180718235710.18242-9-jmkrzyszt@gmail.com>
Message-ID: <20180719084749.25ca96a6@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Jul 2018 01:57:10 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Don't readw()/writew() data directly from/to GPIO port which is under
> control of gpio-omap driver, use GPIO chip callbacks instead.
> 
> Thanks to utilization of get/set_multiple() callbacks, performance
> degrade is minor for typical data transfers.

Same comment here, don't use the gpio_chip hooks directly, use the
consumer API instead.

> 
> The driver should now work with any 8+-bit bidirectional GPIO port,
> not only OMAP.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> 
> # Conflicts:
> #	drivers/mtd/nand/raw/ams-delta.c

Oh, some leftovers from a conflict resolution :).
