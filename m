From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 28 Aug 2013 03:02:36 +0200
Subject: [PATCH V2 2/4] clk: exynos-audss: set correct parent clocks
In-Reply-To: <20130828004341.8231.3654@quantum>
References: <1376639378-20707-1-git-send-email-padma.v@samsung.com>
 <1376639378-20707-3-git-send-email-padma.v@samsung.com>
 <20130828004341.8231.3654@quantum>
Message-ID: <7654693.FMY6qS63O6@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 of August 2013 17:43:41 Mike Turquette wrote:
> Quoting Padmavathi Venna (2013-08-16 00:49:36)
> 
> > From: Andrew Bresticker <abrestic@chromium.org>
> > 
> > Different Exynos SoCs have different names for certain input clocks
> > to the AudioSS block.  Since the order in which clock providers are
> > probed is not guaranteed, we can't use the device-tree to pass the
> > correct input clocks.
> 
> Why not? Could your audss binding include something like a "clocks"
> property with phandles to the input clocks? Then your audss clock driver
> could just use clk_get like a regular driver to get the parents.

AFAIR, the driver is currently probed using of_clk_init(), so the reason 
was probably being unable to defer probing.

However this is not the core system clock controller, so I believe there 
is no reason for it not to be a normal platform driver.

Best regards,
Tomasz
