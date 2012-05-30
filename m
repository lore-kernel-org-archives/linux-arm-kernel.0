From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 30 May 2012 11:02:24 +0300
Subject: [PATCHv5 5/8] ARM: OMAP: hwmod: Add support for per
 hwmod/module context lost count
In-Reply-To: <CAOMWX4eKp+JymSNyapRJ3+u=Q1U-yMyFS5M6KUe7pOgOYyt6Ug@mail.gmail.com>
References: <1336989796-26594-1-git-send-email-t-kristo@ti.com>
 <1336989796-26594-6-git-send-email-t-kristo@ti.com>
 <CAOMWX4eKp+JymSNyapRJ3+u=Q1U-yMyFS5M6KUe7pOgOYyt6Ug@mail.gmail.com>
Message-ID: <1338364944.8834.104.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-05-29 at 14:32 -0500, Menon, Nishanth wrote:
> On Mon, May 14, 2012 at 5:03 AM, Tero Kristo <t-kristo@ti.com> wrote:
> [...]
> > +/**
> >  * _enable - enable an omap_hwmod
> >  * @oh: struct omap_hwmod *
> >  *
> > @@ -1599,6 +1629,8 @@ static int _enable(struct omap_hwmod *oh)
> >        _enable_clocks(oh);
> >        _enable_module(oh);
> >
> > +       _omap4_update_context_lost(oh);
> > +
> >        r = _wait_target_ready(oh);
> >        if (!r) {
> >                /*
> 
> Dumb q: Since we monitor the count around _enable, how do we ensure
> that context loss counter is accurate
> around OFF and idle transitions for domains that could have been
> hwauto? it might be good to have limitations
> in the $commit_message if it is not targeted to do so.

True, I can add a comment to the commit msg about this.

-Tero
