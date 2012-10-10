From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 10 Oct 2012 10:01:56 +0200
Subject: [PATCH] i.MX25 clk fixes
Message-ID: <1349856119-22363-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following are some fixes for the i.MX25 clk support. I came
up with these when matching the clocks with the datasheet. They
are untested as I currently have no hardware which makes use of
these clocks, so I'd be happy if someone could have a look before
they get applied.

BTW I have prepared another patch which adds the missing gates
to the i.MX25 clk support. I'll come up with this after the merge
window when I have rebased the i.MX25 devicetree support on it.

Sascha

----------------------------------------------------------------
Sascha Hauer (3):
      ARM i.MX25: Fix lcdc_ipg_per parent clock
      ARM i.MX25 clk: Fix nfc_ipg_per parent
      ARM i.MX25: Fix PWM per clock lookups

 arch/arm/mach-imx/clk-imx25.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
