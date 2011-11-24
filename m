From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Nov 2011 17:08:55 -0800
Subject: [PATCH v3 5/5] clk: export tree topology and clk data via sysfs
In-Reply-To: <20111123224248.GC19739@n2100.arm.linux.org.uk>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-6-git-send-email-mturquette@linaro.org>
 <20111122154900.GB18954@kroah.com>
 <CAPtuhThPQtWwihE8aGru55k87oV7QOr=O836TTJ+=30d6dtVhA@mail.gmail.com>
 <20111122191347.GB4844@kroah.com>
 <20111123165903.GF31337@atomide.com>
 <20111123180651.GB19739@n2100.arm.linux.org.uk>
 <20111123185518.GG31337@atomide.com>
 <20111123224248.GC19739@n2100.arm.linux.org.uk>
Message-ID: <20111124010855.GN31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [111123 14:07]:
> On Wed, Nov 23, 2011 at 10:55:19AM -0800, Tony Lindgren wrote:
> > What else are you aware of that is really needed early for clocks other
> > than clockevent?
> 
> TWD will lose its auto-calibration.  Then there's various clock source
> and clock event implementations.  These all call for the clk API to be
> up and running at init_early time.

If we can't initialize those later on, then it sounds like some clocks
and some parts of the clock fwk code needs to be static.

However, we could still make big chunks of the clock framework into a
regular device driver for allocating non-static clocks, debugfs interface
and so on.

Regards,

Tony
