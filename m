From: mturquette@linaro.org (Mike Turquette)
Date: Sat, 08 Jun 2013 11:25:03 -0700
Subject: [PATCH RFC 0/3] clk: dt: bindings for mux & divider clocks
In-Reply-To: <20130608030240.GB22134@S2101-09.ap.freescale.net>
References: <1370281990-15090-1-git-send-email-mturquette@linaro.org>
 <20130607055128.GA20780@S2101-09.ap.freescale.net>
 <20130607175254.10233.7661@quantum>
 <20130608030240.GB22134@S2101-09.ap.freescale.net>
Message-ID: <20130608182503.10233.30556@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Shawn Guo (2013-06-07 20:02:41)
> On Fri, Jun 07, 2013 at 10:52:54AM -0700, Mike Turquette wrote:
> > Yes, there was a time when I was firmly against doing such a thing.
> > However I'm not sure it is so bad now.  More and more SoCs are going to
> > keep getting merged into the kernel and that just means more and more
> > clock data.  Perhaps DT is best suited to handle this bloat.  I broke
> > the clock data out into a separate file so that it didn't overwhelm the
> > existing omap4.dtsi.
> 
> I'm actually more concerned by run-time impact.  Any of_find_node_*()
> call will possibly have to scan all those hundreds of nodes to find the
> desired one.  Anyway, it's an OMAP folks decision, and the impact might
> not be that much on those fast CPUs.
> 

Agreed.  Once the conversion is complete we'll have to measure and see
if any negligible boot-time latency is present.  Alternatively we could
avoid registering the whole clock framework at boot time and instead
register clocks as needed (either by loading the omap4 clock driver
module or even on a per-device basis).  Tony has hinted at this a few
times.

Regards,
Mike

> Shawn
> 
> > 
> > Either way I marked this series as RFC precisely due to your point.  I
> > want feedback on how the OMAP folks feel about this.  So far no has has
> > NACKed it ;-)
