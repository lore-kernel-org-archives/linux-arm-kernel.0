From: johan@kernel.org (Johan Hovold)
Date: Fri, 31 Jul 2015 10:44:56 +0200
Subject: [PATCH 7/9] gpiolib-sysfs: Add gpio name parsing for sysfs export
In-Reply-To: <20150729065736.GE30895@pengutronix.de>
References: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
 <1437125570-28623-8-git-send-email-mpa@pengutronix.de>
 <20150728095004.GM28535@localhost>
 <20150729065736.GE30895@pengutronix.de>
Message-ID: <20150731084456.GN28535@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 08:57:36AM +0200, Markus Pargmann wrote:
> On Tue, Jul 28, 2015 at 11:50:04AM +0200, Johan Hovold wrote:
> > On Fri, Jul 17, 2015 at 11:32:48AM +0200, Markus Pargmann wrote:

> > > +		char *gpio_name = kstrdup(buf, GFP_KERNEL);
> > 
> > Must check for allocation failures, but why use kstrdup at all?
> 
> Yes have to check that.
> strim() may modify the buf variable which is constant.
>
> > > +
> > > +		desc = gpio_name_to_desc(strim(gpio_name));

Ah, I missed that strim.

Johan
