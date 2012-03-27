From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 27 Mar 2012 21:40:10 +0200
Subject: [PATCH 09/10] clk: dynamically allocate parent_names basic clk
 registration
In-Reply-To: <20120327125122.GB3719@S2101-09.ap.freescale.net>
References: <1332833009-4121-1-git-send-email-shawn.guo@linaro.org>
 <1332833009-4121-10-git-send-email-shawn.guo@linaro.org>
 <20120327085514.GI29317@pengutronix.de>
 <20120327125122.GB3719@S2101-09.ap.freescale.net>
Message-ID: <20120327194010.GJ29317@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2012 at 08:51:24PM +0800, Shawn Guo wrote:
> On Tue, Mar 27, 2012 at 10:55:14AM +0200, Sascha Hauer wrote:
> > On Tue, Mar 27, 2012 at 03:23:28PM +0800, Shawn Guo wrote:
> > > It's not necessary to have "char *parent[1]" carried in struct clk_gate
> > > and clk_divider.  Instead, it can be dynamically allocated in
> > > registration function, just like what clk_register_fixed_rate does.
> > 
> > I patched it the way it is to get rid of the additional malloc which
> > seemed unnecessary. Maybe the real question is whether the core should
> > duplicate the parent strings instead of the basic clock types.
> > 
> If we can ensure the parent strings will only be used during
> clk_register call, we do not need to duplicate the parent strings.
> 
> But right now the parent strings is used not only in clk_register call
> but also __clk_set_parent for finding parent index in case the search
> on cached parent points fails.  I guess Mike has a good reason for that.

Probably. That's why I suggest to copy the strings in the framework.
Then we do not have to duplicate the code to copy the strings and also
make sure that the core works on its own strings.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
