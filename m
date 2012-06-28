From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Thu, 28 Jun 2012 20:11:26 +0800
Subject: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
In-Reply-To: <20120628120522.GH22990@S2101-09.ap.freescale.net>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
 <4FEC329C.7070004@pengutronix.de>
 <20120628112111.GC22990@S2101-09.ap.freescale.net>
 <4FEC400F.8010506@pengutronix.de>
 <20120628114108.GD22990@S2101-09.ap.freescale.net>
 <20120628115224.GF22990@S2101-09.ap.freescale.net>
 <20120628120522.GH22990@S2101-09.ap.freescale.net>
Message-ID: <20120628121125.GN6406@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 08:05:24PM +0800, Shawn Guo wrote:
> On Thu, Jun 28, 2012 at 07:52:26PM +0800, Shawn Guo wrote:
> > Do you care the variable name also?  If so, we will get:
> > 
> >         int transceiver_en_gpio;
> >         int transceiver_stby_gpio;
> >         bool transceiver_en_high;
> >         bool transceiver_stby_high;
> > 
> > So everything becomes long :)
> > 
> Oh, even longer, since we have agreed "high" should be renamed to
> "active_low":
> 
> 	bool transceiver_en_active_low;
> 	bool transceiver_stby_active_low;
> 
How about just active_low since they're just temp variables?

And if you do not assign them together at last, you may only need:
int gpio;
bool active_high;

That saves you two variables.

Regards
Dong Aisheng
