From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat,  1 Apr 2017 15:10:00 +0200
Subject: [PATCH 0/1] add support for the NAND clocks on Meson8b
Message-ID: <20170401131001.9988-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the NAND clocks found in the Meson8b SoC.
The clocks consist of a simple gate, a divider and a mux. The mux
parents are not documented in the public S805 datasheet [0], so I
had to use a bit of math and take the vendor kernel as reference [1]
to find the actual parent clocks.
Some mux parents cannot be divided down without remainder to the
target clocks (as expected by the vendor NAND driver) these clocks
have the ROUND_CLOSEST flag set.

This is based on the "clk-meson" branch (e65ae3fb97b4 "dt-bindings:
clock: gxbb-clkc: Add GXL compatible variant")


[0] http://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf
[1] https://github.com/khadas/linux/blob/9587681285cb/drivers/amlogic/amlnf/dev/amlnf_ctrl.c#L314

Martin Blumenstingl (1):
  clk: meson: meson8b: add support for the NAND clocks

 drivers/clk/meson/meson8b.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/meson8b.h |  6 ++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

-- 
2.12.1
