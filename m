From: tony@atomide.com (Tony Lindgren)
Date: Tue, 23 Dec 2014 08:56:35 -0800
Subject: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
In-Reply-To: <20141223161936.GA9147@saruman>
References: <1419271535-4057-1-git-send-email-balbi@ti.com>
 <54991A25.2030804@compulab.co.il> <20141223161936.GA9147@saruman>
Message-ID: <20141223165634.GL23854@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [141223 08:22]:
> On Tue, Dec 23, 2014 at 09:30:45AM +0200, Igor Grinberg wrote:
> > On 12/22/14 20:05, Felipe Balbi wrote:
> > >  CONFIG_DEBUG_GPIO=y
> > >  CONFIG_GPIO_SYSFS=y
> > > -CONFIG_GPIO_TWL4030=y
> > > -CONFIG_W1=y
> > > +CONFIG_GPIO_TWL4030=m
> > 
> > w/o this devices wired to twl gpios will not come up and likely
> > will miss the enumeration...
> 
> for example ?

The TWL4030 part needs to be checked for the legacy booting to
make sure the board-*.c file *_twl_gpio_setup() callbacks still
work properly. Or you may want to leave it for later.

Regards,

Tony
