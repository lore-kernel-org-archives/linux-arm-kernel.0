From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 17 Jan 2013 11:45:21 +0100
Subject: [PATCH 7/7] ARM i.MX5: Add system reset controller (SRC) to
 i.MX51 and i.MX53 device tree
In-Reply-To: <50F72780.8040208@wwwdotorg.org>
References: <1358352787-15441-1-git-send-email-p.zabel@pengutronix.de>
 <1358352787-15441-8-git-send-email-p.zabel@pengutronix.de>
 <50F72780.8040208@wwwdotorg.org>
Message-ID: <1358419521.2411.125.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 16.01.2013, 15:19 -0700 schrieb Stephen Warren:
> On 01/16/2013 09:13 AM, Philipp Zabel wrote:
> > Also, link SRC to IPU via phandle.
> 
> Aside from the comments I already made, the series,
> Reviewed-by: Stephen Warren <swarren@nvidia.com>

Thank you.

> although I'm not 100% sure if the ordering of patches maintains a
> working i.MX build all the time? Does "git bisect" work across the series?

Since IPU probing doesn't succeed if device_reset() fails, the IPU patch
needs to be ordered after the i.MX5 patches.

On the other hand, should device_reset() fail at all if no reset
controller was specified in the device tree?

regards
Philipp
