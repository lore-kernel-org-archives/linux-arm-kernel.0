From: mturquette@ti.com (Mike Turquette)
Date: Wed, 28 Nov 2012 20:34:36 -0800
Subject: [PATCH 6/6 v6] cpufreq, highbank: add support for highbank cpufreq
In-Reply-To: <20121129015133.GD28170@S2100-06.ap.freescale.net>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354046672-7392-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354046672-7392-7-git-send-email-mark.langsdorf@calxeda.com>
 <20121128023240.GA28170@S2100-06.ap.freescale.net>
 <50B60E9C.9000405@calxeda.com>
 <20121128145759.GB28170@S2100-06.ap.freescale.net>
 <20121128151741.GC28170@S2100-06.ap.freescale.net>
 <20121128160115.21126.3841@nucleus>
 <20121129015133.GD28170@S2100-06.ap.freescale.net>
Message-ID: <20121129043436.21126.714@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Shawn Guo (2012-11-28 17:51:36)
> > The notifiers in the clk framework might be a better place for this than
> > just simply hacking the logic into the .set_rate callback.
> 
> Ah, right.  How did I forget about that nice piece?
> 
> > I haven't looked at the definition of hb_voltage_change but does the
> > call graph make any clk api calls?  Are you talking over i2c to a
> > regulator?  If so then you'll probably hit the same reentrancy problem I
> > hit when trying to make a general solution.
> 
> So, how is your "reentrancy in the common clk framework" series[1]
> going on?  Haven't seen any update since August.
> 

I've begun to look at a dvfs api that builds on top of the clock
framework, as opposed to using clk_set_rate as the dvfs api itself.
This eliminates the need for reentrancy, at least for the dvfs case.

I'll post more when I have it.  Honestly the reentrancy stuff was just
too ugly.  I might try again some day but for now I'm thinking a less
radical approach deserves consideration.

Thanks,
Mike

> Shawn
> 
> [1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/182198
