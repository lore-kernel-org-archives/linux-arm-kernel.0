From: tony@atomide.com (Tony Lindgren)
Date: Fri, 26 Oct 2012 13:16:31 -0700
Subject: [PATCH v2 3/3] ARM: OMAP: ocp2scp: create omap device for ocp2scp
In-Reply-To: <20121026195958.GB29548@arwen.pp.htv.fi>
References: <1349675983-23803-1-git-send-email-kishon@ti.com>
 <1349675983-23803-4-git-send-email-kishon@ti.com>
 <20121026065012.GC22206@arwen.pp.htv.fi>
 <201210260747.11848.arnd@arndb.de>
 <20121026172140.GJ11908@atomide.com>
 <20121026195958.GB29548@arwen.pp.htv.fi>
Message-ID: <20121026201631.GR11908@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [121026 13:07]:
> On Fri, Oct 26, 2012 at 10:21:41AM -0700, Tony Lindgren wrote:
> > * Arnd Bergmann <arnd@arndb.de> [121026 00:48]:
> > > On Friday 26 October 2012, Felipe Balbi wrote:
> > > > > +static void omap_init_ocp2scp(void)
> > > > > +{
> > > > > +     struct omap_hwmod       *oh;
> > > > > +     struct platform_device  *pdev;
> > > > > +     int                     bus_id = -1, dev_cnt = 0, i;
> > > > > +     struct omap_ocp2scp_dev *ocp2scp_dev;
> > > > > +     const char              *oh_name, *name;
> > > > > +     struct omap_ocp2scp_platform_data *pdata;
> > > > > +
> > > > > +     oh_name = "ocp2scp_usb_phy";
> > > > > +     name    = "omap-ocp2scp";
> > > > 
> > > > how about adding checks here to return early case we're not running on
> > > > OMAP4 or OMAP5 ??
> > > > 
> > > 
> > > I suppose even OMAP4-only, since OMAP5 always has DT enabled.
> > 
> > Hmm yes, currently omap_hwmod_lookup(oh_name) produces
> > bogus errors for other omaps as the hwmod data is only
> > there for omap4.
> 
> shouldn't that be fixed too ? I mean, if data isn't just return -ENODEV
> or something similar.

Yes some kind of checking is needed here.

Regards,

Tony
