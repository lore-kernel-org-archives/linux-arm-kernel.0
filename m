From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 27 Jul 2017 18:17:53 +0200
Subject: [PATCH 0/2] clk: meson: fix protection against undefined clks
Message-ID: <20170727161755.10393-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the last clkids defined have no hw pointer associated with them in
the hw_onecell_data array, the initialization is going to crash badly
because the array is not big enough.

The patchset makes sure the array is big enough, and that each clkid is
associated with a valid hw pointer, or NULL.

Doing it in two patches to ease backport, since we are not fixing the
same commit on meson8b and gxbb

Jerome Brunet (2):
  clk: meson: meson8b: fix protection against undefined clks
  clk: meson: gxbb: fix protection against undefined clks

 drivers/clk/meson/gxbb.c    | 2 ++
 drivers/clk/meson/meson8b.c | 1 +
 2 files changed, 3 insertions(+)

-- 
2.9.4
