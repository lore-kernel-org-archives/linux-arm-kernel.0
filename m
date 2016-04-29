From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 29 Apr 2016 14:43:13 +0200
Subject: [PATCH v2 2/3] ARM: imx6: rework GPC to support multiple power
 domains
In-Reply-To: <20160407024857.GA3111@x250>
References: <1458128514-9560-1-git-send-email-l.stach@pengutronix.de>
 <1458128514-9560-2-git-send-email-l.stach@pengutronix.de>
 <20160407024857.GA3111@x250>
Message-ID: <1461933793.3482.24.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 07.04.2016, 10:48 +0800 schrieb Shawn Guo:
> On Wed, Mar 16, 2016 at 12:41:53PM +0100, Lucas Stach wrote:
> > This largely reworks the GPC driver to better accommodate multiple
> > power domains. This allows to extend the driver to support more domains
> > (like present on i.MX6SX) easily later on.
> > 
> > Compatibility to the old DT bindings is provided to keep the currently
> > supported i.MX6 devices working with the same feature level as before.
> > New DTs and SoC support should only use the new binding from now on.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> > v2: correct spelling in commit message
> > ---
> >  arch/arm/mach-imx/gpc.c | 435 ++++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 329 insertions(+), 106 deletions(-)
> 
> There are too many changes in this single patch.  It makes the review
> quite difficult.  Is it possible to split it a bit into some incremental
> patches?
> 
I see that this is a quite difficult transformation and hard to review,
but it's also equally hard to split up without introducing regressions
and breaking bisectability in the series. This would cost me at least a
full day to revalidate the changes, time which I currently don't have
available.

Maybe it's easier to review if you apply the change and look at the
resulting code?

> Also please rebase against v4.6-rc1, which has the commit eaa2d73ef998
> (ARM: imx6: pm: declare pm domain latency on power_state struct)
> conflicting with your changes.
> 
I can do that if you are willing to take it in the current form. If you
still want to have it split up, I'll keep it blocked on -ENOTIME.

Regards,
Lucas
