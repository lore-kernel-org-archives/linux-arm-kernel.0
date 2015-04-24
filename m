From: tony@atomide.com (Tony Lindgren)
Date: Fri, 24 Apr 2015 09:22:47 -0700
Subject: [PATCH] gpio: omap: Allow building as a loadable module
In-Reply-To: <20150424161127.GG5692@saruman.tx.rr.com>
References: <1429833382-28532-1-git-send-email-tony@atomide.com>
 <20150424161127.GG5692@saruman.tx.rr.com>
Message-ID: <20150424162247.GT18048@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [150424 09:14]:
> On Thu, Apr 23, 2015 at 04:56:22PM -0700, Tony Lindgren wrote:
> > We currently get all kinds of errors building the omap gpio driver
> > as a module starting with:
> > 
> > undefined reference to `omap2_gpio_resume_after_idle'
> > undefined reference to `omap2_gpio_prepare_for_idle'
> > ...
> > 
> > Let's fix the issue by adding inline functions to the header.
> > Note that we can now also remove the two unused functions for
> > omap_set_gpio_debounce and omap_set_gpio_debounce_time.
> > 
> > Then doing rmmod on the module produces further warnings
> > because of missing exit related functions. Let's add those.
> > 
> > And finally, we can make the Kconfig entry just a tristate
> > option that's selected for omaps.
> > 
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Javier Martinez Canillas <javier@dowhile0.org>
> > Cc: Grygorii Strashko <grygorii.strashko@linaro.org>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Nishanth Menon <nm@ti.com>
> > Cc: Santosh Shilimkar <ssantosh@kernel.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Just to be clear: when GPIO is a module, we can't really idle, can we ?

Right we cannot do off idle because of the context loss
until we have some way to register driver specific idle
functions.

Regards,

Tony
