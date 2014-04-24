From: tony@atomide.com (Tony Lindgren)
Date: Thu, 24 Apr 2014 11:44:58 -0700
Subject: [PATCH 2/2] ARM: OMAP2+: fix dpll round_rate() to actually round
In-Reply-To: <20140424182914.GD4659@saruman.home>
References: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com>
 <1389944699-27962-3-git-send-email-tomi.valkeinen@ti.com>
 <20140424182914.GD4659@saruman.home>
Message-ID: <20140424184457.GH22987@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [140424 11:29]:
> Hi,
> 
> On Fri, Jan 17, 2014 at 09:44:59AM +0200, Tomi Valkeinen wrote:
> > omap2_dpll_round_rate() doesn't actually round the given rate, even if
> > the name and the description so hints. Instead it only tries to find an
> > exact rate match, or if that fails, return ~0 as an error.
> > 
> > What this basically means is that the user of the clock needs to know
> > what rates the dpll can support, which obviously isn't right.
> > 
> > This patch adds a simple method of rounding: during the iteration, the
> > code keeps track of the closest rate match. If no exact match is found,
> > the closest is returned.
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> Tony, looks like this patch was lost. Are you taking it during the -rc ?

Would like to hear what Paul thinks of the updated patch suggested
by Tomi first.

Tony
