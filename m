From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 8 Aug 2012 16:24:12 +0530
Subject: [PATCH 0/2] OMAP cpufreq fixes
Message-ID: <1344423254-3475-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

While testing cpufreq on 3.6-rc1, I noticed strange issues on OMAP4,
like a lockup when booting with 'performace' governer as default,
and crashes when using 'usespace' (which booted up) and switching
to higher OPPs.
It took me a while to realise I was using a 4460 device. The OPPs
registered though seemed to be for 4430 and hence were causing
issues on the 4460 device. 

This series basically avoids registering the 4430 OPPs on other
varients like 4460 and 4470 (and hence causing random issues)
and also fixes a subsequent bug uncovered by doing this in
OMAP cpufreq driver.

regards,
Rajendra 

Rajendra Nayak (2):
  cpufreq: OMAP: Handle missing frequency table on SMP systems
  ARM: OMAP4: Register the OPP table only for 4430 device

 arch/arm/mach-omap2/opp4xxx_data.c |    2 +-
 drivers/cpufreq/omap-cpufreq.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.7.9.5
