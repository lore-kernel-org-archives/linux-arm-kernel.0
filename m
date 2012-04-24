From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 24 Apr 2012 21:26:51 +0800
Subject: [PATCH 1/2] pinctrl: add pinctrl-mxs support
In-Reply-To: <CACRpkdZ0USvyvT-YB3=VM5rb3VQ9-kVRwarZL82jMCz4J_wgUg@mail.gmail.com>
References: <1334823125-24159-1-git-send-email-shawn.guo@linaro.org>
 <20120421164713.GA3408@das-ThinkPad-X61>
 <20120422163255.GD26306@S2101-09.ap.freescale.net>
 <20120423074702.GD24843@shlinux2.ap.freescale.net>
 <20120423144623.GU26306@S2101-09.ap.freescale.net>
 <20120424034010.GA32166@shlinux2.ap.freescale.net>
 <20120424040520.GC26306@S2101-09.ap.freescale.net>
 <CACRpkdZ0USvyvT-YB3=VM5rb3VQ9-kVRwarZL82jMCz4J_wgUg@mail.gmail.com>
Message-ID: <20120424132648.GF26306@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 03:07:35PM +0200, Linus Walleij wrote:
> Hm, that's pretty interesting - but are imx and mxs even going to use the
> same driver then? Maybe I'm not following - are they similar
> in all other aspects than for this pin config stuff?
> 
The mach-mxs (i.MX23 and i.MX28) is a totally different sub-architecture
from mach-imx.  Freescale acquired it from SigmaTel a few years back.
These two sub-architectures have completely different pin controllers.
So, no, they are not going to use the same pinctrl driver but two
different ones, pinctrl-mxs and pinctrl-imx.

The only common aspect is both two controllers only supports pin basis
configuration (no hardware pingroup).  I think many other
sub-architectures including omap are same on this aspect.

> Whether to use properties or raw values or not I cleverly leave up
> to the platform to define and solve, unless they want to use
> the generic pinprops library.
> 
That's my position too.

-- 
Regards,
Shawn
