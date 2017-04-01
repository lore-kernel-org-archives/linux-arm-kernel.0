From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat,  1 Apr 2017 15:02:23 +0200
Subject: [PATCH 0/2] clk: meson: MPLL fixes for Meson8b
Message-ID: <20170401130225.8811-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome recently added the MPLL clocks to the Meson8b clock driver: [0]

On my board this unfortunatley causes a division by zero error which
is fixed by patch #1 in this series.

While investigating this I found that there also seems to be a 32bit
overflow in the calculation in rate_from_params(), which is fixed by
patch #2 in this series.
If the review of patch #2 reveals problems then patch #1 should still
be applied.

This series is based to the "clk-meson" branch (e65ae3fb97b4
"dt-bindings: clock: gxbb-clkc: Add GXL compatible variant").


[0] http://lists.infradead.org/pipermail/linux-amlogic/2017-March/002757.html

Martin Blumenstingl (2):
  clk: meson: mpll: fix division by zero in rate_from_params
  clk: meson: mpll: use 64bit math in rate_from_params

 drivers/clk/meson/clk-mpll.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.12.1
