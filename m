From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 5 Dec 2013 19:29:39 +0100
Subject: [PATCH v4 2/4] mvebu: Dove: Instantiate cpufreq driver.
In-Reply-To: <20131205175434.GQ29200@e106331-lin.cambridge.arm.com>
References: <1386166641-7567-1-git-send-email-andrew@lunn.ch>
 <1386166641-7567-3-git-send-email-andrew@lunn.ch>
 <20131204143628.GB29200@e106331-lin.cambridge.arm.com>
 <20131204150228.GB8062@lunn.ch>
 <20131205175434.GQ29200@e106331-lin.cambridge.arm.com>
Message-ID: <20131205182939.GB19067@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I'm not arguing for describing a pseudo-device. The power management
> unit is a real device. If we used that to register a cpufreq driver, it
> doesn't mean that we've registered a pseudo-device, but rather that we
> made a decision to register the cpufreq portions based on the necessary
> real devices being present.

Hi Mark

I need a more concrete explanation to understand what you mean.

Are you suggesting that i add a drivers/pmu/dove.c, which gets
instantiated by DT? This driver would then instantiate the cpufreq
driver? If so, it should also instantiate the gated clocks in
drivers/clk/mvebu/dove.c, since they are also part of the PMU,
according to the data sheet.  The RTC and the thermal management unit
are also part of the PMU. Should these drivers also be instantiated by
the PMU somehow?

> Perhaps this was the problem with the proposed kirkwood binding?

Kirkwood does not have a PMU, at least not according to the data
sheet. There are registers to control cpuidle, cpufreq, gating some
clocks, the exact same RTC and a somewhat similar thermal
sensor. However the data sheet makes no reference as to calling the
collection the "PMU".

   Thanks
      Andrew	   
