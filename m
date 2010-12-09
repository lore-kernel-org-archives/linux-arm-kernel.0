From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 9 Dec 2010 23:13:32 +0100
Subject: [PATCH v2 0/8] OMAP3&4: clock data: Fixes and add new clocks nodes
Message-ID: <1291932820-11163-1-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

Here is a collections of fixes and clock nodes addition done on OMAP3
and OMAP4 clock data files.

I have included the one that Thara already submitted after fixing the
various comments done on the original version.

That revision include as well a new fix from Jon. Thanks to both fixes,
the clocks rate are now accurate and the func_48m_fclk does report 48MHz
now! Cool isn't it?

Tested on sdp4430 + ES2.0.

The series is based on 2.6.37-rc5 and is available here:
git://gitorious.org/omap-pm/linux.git for_2.6.38/clock

Regards,
Benoit


Benoit Cousson (3):
  OMAP4: clock data: Add control for pad_clks_ck and slimbus_clk
  OMAP3: clock data: Add "wkup_clkdm" in sr1_fck and sr2_fck
  OMAP4: PRCM: Add SCRM header file

Jon Hunter (1):
  OMAP4: clock data: Add missing fixed divisors

Jonathan Bergsagel (1):
  OMAP4: clock data: Add missing fields in iva_hsd_byp_clk_mux_ck

Rajendra Nayak (2):
  OMAP4: clock data: Add SCRM auxiliary clock nodes
  OMAP4: clock data: Export control to enable/disable CORE/PER M3
    clocks

Thara Gopinath (1):
  OMAP4: clock data: Add missing DPLL x2 clock nodes

 arch/arm/mach-omap2/clock3xxx_data.c |    2 +
 arch/arm/mach-omap2/clock44xx_data.c |  653 ++++++++++++++++++++++++----------
 arch/arm/mach-omap2/scrm44xx.h       |  176 +++++++++
 3 files changed, 640 insertions(+), 191 deletions(-)
 create mode 100644 arch/arm/mach-omap2/scrm44xx.h
