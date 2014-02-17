From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 17 Feb 2014 20:42:57 -0300
Subject: [PATCH v7 11/18] watchdog: orion: Add per-compatible watchdog
 start implementation
In-Reply-To: <20140217211113.GD7862@titan.lakedaemon.net>
References: <1392073237-2554-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1392073237-2554-12-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140217210822.GC7862@titan.lakedaemon.net>
 <20140217211113.GD7862@titan.lakedaemon.net>
Message-ID: <20140217234256.GA28783@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 04:11:13PM -0500, Jason Cooper wrote:
> On Mon, Feb 17, 2014 at 04:08:22PM -0500, Jason Cooper wrote:
> > On Mon, Feb 10, 2014 at 08:00:30PM -0300, Ezequiel Garcia wrote:
> > > To handle differences between SoCs this commit adds per-compatible
> > > string start() function for the watchdog kick-off. This is preparation
> > > work and makes no functionality changes to the current driver.
> > > 
> > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > > Tested-by: Willy Tarreau <w@1wt.eu>
> > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > ---
> > >  drivers/watchdog/orion_wdt.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> > > index b48fd08..3925297 100644
> > > --- a/drivers/watchdog/orion_wdt.c
> > > +++ b/drivers/watchdog/orion_wdt.c
> > > @@ -50,6 +50,7 @@ struct orion_watchdog_data {
> > >  	int rstout_enable_bit;
> > 
> > 
> > >  	int (*clock_init)(struct platform_device *,
> > >  			  struct orion_watchdog *);
> > 
> > this...
> > 
> > > +	int (*start)(struct watchdog_device *);
> > >  };
> > >  
> > >  struct orion_watchdog {
> > ...
> > > @@ -193,6 +202,7 @@ static const struct orion_watchdog_data orion_data = {
> > >  	.wdt_enable_bit = BIT(4),
> > >  	.wdt_counter_offset = 0x24,
> > 
> > 
> > >  	.clock_init = orion_wdt_clock_init,
> > 
> > and this...
> > 
> > > +	.start = orion_start,
> > >  };
> > 
> > cause a failure to apply the patch.  I hand-jammed it (attached), please
> > let me know what is going on here (missed dep?)
> 
> disregard.  I missed patch 10.  It helps.  :)
> 

Phhheeew... my heart stopped for a minute ;-)
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
