From: tony@atomide.com (Tony Lindgren)
Date: Thu, 20 Jun 2013 00:21:14 -0700
Subject: [RFC PATCH 2/6] mfd: omap-usb-host: Put pins in IDLE state on
 suspend
In-Reply-To: <878v26815g.fsf@linaro.org>
References: <1371650753-11452-1-git-send-email-rogerq@ti.com>
 <1371650753-11452-3-git-send-email-rogerq@ti.com>
 <878v26815g.fsf@linaro.org>
Message-ID: <20130620072112.GF5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@linaro.org> [130619 10:30]:
> Hi Roger,
> 
> Roger Quadros <rogerq@ti.com> writes:
> 
> > In order to support wake up from suspend use the pinctrl
> > framework to put the USB host pins in IDLE state during suspend.
> >
> > CC: Samuel Ortiz <sameo@linux.intel.com>
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> You should use helpers for this now in the pinctrl core:
> 
>     http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/173514.html

Also see the thread "[PATCH] pinctrl: document the pinctrl PM states"
as we're still discussing how to deal with the various dynamic
pinctrl needs in a generic way. Meanwile, just make sure the other
patches work and don't break anything without this patch to
remove the dependency.

Regards,

Tony
