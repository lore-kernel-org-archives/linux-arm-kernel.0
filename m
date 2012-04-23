From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 24 Apr 2012 07:25:16 +0800
Subject: [PATCH 1/2] pinctrl: add pinctrl-mxs support
In-Reply-To: <4F95A71B.6090808@wwwdotorg.org>
References: <1334823125-24159-1-git-send-email-shawn.guo@linaro.org>
 <20120421164713.GA3408@das-ThinkPad-X61>
 <20120422163255.GD26306@S2101-09.ap.freescale.net>
 <20120423074702.GD24843@shlinux2.ap.freescale.net>
 <20120423144623.GU26306@S2101-09.ap.freescale.net>
 <4F95A71B.6090808@wwwdotorg.org>
Message-ID: <20120423232515.GX26306@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 01:01:47PM -0600, Stephen Warren wrote:
> I can't really comment on what Dong was suggesting, but. The Tegra
> bindings have a 2-level binding - a top-level node per state, and then
> an arbitrary number of nodes that configuration something (mux, or
> config, or both) for an arbitrary set of pins. That allows you to
> represent any possible set of mux/config variations with no duplication
> of those mux/config values, e.g.:
> 
>                 state_i2cmux_ddc: pinmux_i2cmux_ddc {
>                         ddc {
>                                 nvidia,pins = "ddc";
>                                 nvidia,function = "i2c2";
>                         };
>                         pta {
>                                 nvidia,pins = "pta";
>                                 nvidia,function = "rsvd4";
>                         };
>                         conf {
>                                 nvidia,pins = "ddc", "pta";
>                                 nvidia,pull = <1>;
>                         };
>                 };
> 
> This is very flexible and about as minimal as you can get from a
> repetitiveness point-of-view.
> 
> However, I guess it doesn't play too well into your desire to create the
> group and function definitions from device tree. That's part of the
> reason I don't like doing that; the SW desire to do that imposes
> artificial restrictions on the rest of the binding.
> 
I think we have agreed that individual pin controller binding can
choose to create the groups and functions from device tree?

> > I think I have a understanding on "function" defined by pinctrl
> > subsystem.  To me, mmc0-4bit and mmc0-8bit are two functions.
> > Linus, help clarify a little bit?
> 
> I suppose there may be disagreement on this, but to me, a function is a
> specific mux option (the HW register value typically) that can be
> selected for a particular pin. Typically, these mux options would
> correspond directly to the HW module whose signals were being muxed onto
> that pin.
> 
Yes, I have read the disagreement between you and Linus.  I created
my understanding by reading Documentation/pinctrl.txt.

-- 
Regards,
Shawn
