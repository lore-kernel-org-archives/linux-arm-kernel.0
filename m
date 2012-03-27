From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 27 Mar 2012 20:51:24 +0800
Subject: [PATCH 09/10] clk: dynamically allocate parent_names basic clk
 registration
In-Reply-To: <20120327085514.GI29317@pengutronix.de>
References: <1332833009-4121-1-git-send-email-shawn.guo@linaro.org>
 <1332833009-4121-10-git-send-email-shawn.guo@linaro.org>
 <20120327085514.GI29317@pengutronix.de>
Message-ID: <20120327125122.GB3719@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2012 at 10:55:14AM +0200, Sascha Hauer wrote:
> On Tue, Mar 27, 2012 at 03:23:28PM +0800, Shawn Guo wrote:
> > It's not necessary to have "char *parent[1]" carried in struct clk_gate
> > and clk_divider.  Instead, it can be dynamically allocated in
> > registration function, just like what clk_register_fixed_rate does.
> 
> I patched it the way it is to get rid of the additional malloc which
> seemed unnecessary. Maybe the real question is whether the core should
> duplicate the parent strings instead of the basic clock types.
> 
If we can ensure the parent strings will only be used during
clk_register call, we do not need to duplicate the parent strings.

But right now the parent strings is used not only in clk_register call
but also __clk_set_parent for finding parent index in case the search
on cached parent points fails.  I guess Mike has a good reason for that.

-- 
Regards,
Shawn
