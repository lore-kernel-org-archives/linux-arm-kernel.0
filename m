From: joe@perches.com (Joe Perches)
Date: Wed, 17 Dec 2014 17:47:45 -0800
Subject: [PATCH v3 1/2] watchdog: Add driver for Mediatek watchdog
In-Reply-To: <20141218013717.GA9855@roeck-us.net>
References: <1418851085-17787-1-git-send-email-matthias.bgg@gmail.com>
 <1418851085-17787-2-git-send-email-matthias.bgg@gmail.com>
 <20141218013717.GA9855@roeck-us.net>
Message-ID: <1418867265.28384.6.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-12-17 at 17:37 -0800, Guenter Roeck wrote:
> On Wed, Dec 17, 2014 at 10:18:04PM +0100, Matthias Brugger wrote:
> > This patch adds a driver for the Mediatek SoC integrated
> > watchdog. This driver supports watchdog and software reset
> > for mt65xx and mt81xx SoCs.
[]
> > diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
[]
> > +static int mtk_reset_handler(struct notifier_block *this, unsigned long mode,
> > +				void *cmd)
> > +{
> > +	struct mtk_wdt_dev *mtk_wdt = container_of(this,
> > +						       struct mtk_wdt_dev,
> > +						       restart_handler);

> I don't really understand the indentation logic you are using.
> Can you make it consistent ?
> 
> I would suggest to align with '(' in the previous line.

Another way is to separate the declaration and the set

	struct mtk_wdt_dev *mtk_wdt;
	void __iomem *wdt_base;

	mtk_wdt = container_of(this, struct mtk_wdt_dev, restart_handler);
	wdt_base = mtk_wdt->wdt_base;
