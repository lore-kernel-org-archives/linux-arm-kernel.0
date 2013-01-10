From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Jan 2013 10:35:01 -0800
Subject: [PATCH 2/2] ARM: dts: omap: Add omap-usb2 dt data
In-Reply-To: <20130110124551.GU28920@arwen.pp.htv.fi>
References: <1348050772-27819-1-git-send-email-kishon@ti.com>
 <1348050772-27819-3-git-send-email-kishon@ti.com>
 <50EE8A89.4010801@ti.com> <50EE921D.8020601@ti.com>
 <50EE9517.3030703@ti.com> <20130110124551.GU28920@arwen.pp.htv.fi>
Message-ID: <20130110183501.GX14149@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [130110 04:49]:
> On Thu, Jan 10, 2013 at 03:46:55PM +0530, kishon wrote:
> > On Thursday 10 January 2013 03:34 PM, Benoit Cousson wrote:
> > >
> > >Rob and I did not agree to use that temp hack in the case of DT, so you
> > >were supposed to repost with a proper driver for the SCM part that
> > >control the USB.
> > 
> > Ok. Missed that. Will work on that.
> 
> Didn't Tony say we should access SCM directly since it's a one time
> thing ?
> 
> Tony ?

The SCM parts should be a separate driver that eventually will be
a child of the minimal SCM core driver. The reason why it should be
separate is because the SCM registers are in a different block as
pointed out by Paul.

There's a good chance that we'll be able to eventually handle the USB
SCM registers directly via pinctrl-single.c using pinconf-bits + generic
pinconf binding. That is pending the changes from Haojian to implement
generic pinconf for pinctrl-single.c.

As the USB SCM registers can get quite complex, I suggest creating a
minimal driver to handle that, and then eventually that driver might
just use the generic pinconf API for setting the SCM registers for
things like bias voltage, pulls and comparators.

Regards,

Tony
