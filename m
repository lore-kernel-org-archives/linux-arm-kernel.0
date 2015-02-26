From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 26 Feb 2015 10:56:58 +0100
Subject: [alsa-devel] [PATCH 1/8] clk: add helper function clk_is_match()
In-Reply-To: <20150226090256.GQ30445@trinity.fluff.org>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-2-git-send-email-shawn.guo@linaro.org>
 <20150225172757.421.43718@quantum>
 <20150226090256.GQ30445@trinity.fluff.org>
Message-ID: <1424944618.3073.6.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 26.02.2015, 09:02 +0000 schrieb Ben Dooks:
> On Wed, Feb 25, 2015 at 09:27:57AM -0800, Mike Turquette wrote:
[...]
> > From: Michael Turquette <mturquette@linaro.org>
> > Date: Wed, 25 Feb 2015 09:11:01 -0800
> > Subject: [PATCH] clk: introduce clk_is_match
> > 
> > Some drivers compare struct clk pointers as a means of knowing
> > if the two pointers reference the same clock hardware. This behavior is
> > dubious (drivers must not dereference struct clk), but did not cause any
> > regressions until the per-user struct clk patch was merged. Now the test
> > for matching clk's will always fail with per-user struct clk's.
> > 
> > clk_is_match is introduced to fix the regression and prevent drivers
> > from comparing the pointers manually.
> 
> small observaton, clk_is_same() is linguistically nicer.

How about clk_equal() ?

regards
Philipp
