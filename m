From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 29 Oct 2012 14:24:48 -0600
Subject: vexpress issues in next-20121029
Message-ID: <508EE610.9050703@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pawel,

I see two issues on vexpress in next-20121029:

1) At compile-time: v2m_timer_init() and v2m_dt_timer_init() reference
functions vexpress_clk_init() and vexpress_clk_of_init() respectively,
which don't appear anywhere in the source tree.

2) With those calls commented out, I find that
vexpress_sysreg_init_leds() is device_initcall, and so executes even
when not running on vexpress HW. This crashes on Tegra (which I have
converted to single-zImage locally).

These appear to come from the following commits:

0891642 ARM: vexpress: Start using new Versatile Express infrastructure
568e5e4 mfd: Versatile Express system registers driver
