From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 29 Nov 2012 09:51:36 +0800
Subject: [PATCH 6/6 v6] cpufreq, highbank: add support for highbank cpufreq
In-Reply-To: <20121128160115.21126.3841@nucleus>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354046672-7392-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354046672-7392-7-git-send-email-mark.langsdorf@calxeda.com>
 <20121128023240.GA28170@S2100-06.ap.freescale.net>
 <50B60E9C.9000405@calxeda.com>
 <20121128145759.GB28170@S2100-06.ap.freescale.net>
 <20121128151741.GC28170@S2100-06.ap.freescale.net>
 <20121128160115.21126.3841@nucleus>
Message-ID: <20121129015133.GD28170@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The notifiers in the clk framework might be a better place for this than
> just simply hacking the logic into the .set_rate callback.

Ah, right.  How did I forget about that nice piece?

> I haven't looked at the definition of hb_voltage_change but does the
> call graph make any clk api calls?  Are you talking over i2c to a
> regulator?  If so then you'll probably hit the same reentrancy problem I
> hit when trying to make a general solution.

So, how is your "reentrancy in the common clk framework" series[1]
going on?  Haven't seen any update since August.

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/182198
