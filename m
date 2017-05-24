From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 24 May 2017 11:39:30 +0200
Subject: [PATCH v2 0/2] clk: meson: mark clk81 as critical
Message-ID: <20170524093932.5262-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GX (gxbb.c) clock controller driver already marks the clk81 clock
as criticial. However, the Meson8b clock controller driver does not do
this yet.
This can lead to a freeze of the whole system when clk81 is disabled
by the common clock framework (for example after the last child clock
is disabled by a driver which used that child clock).

Changes since v1: [0]
With the clock flagged as CRITICAL, CLK_IGNORE_UNUSED is no longer
useful. Remove this flag from meson8b and gxbb's clk81.

[0]: https://lkml.kernel.org/r/20170504183201.13175-1-martin.blumenstingl at googlemail.com

Jerome Brunet (1):
  clk: gxbb: remove CLK_IGNORE_UNUSED from clk81

Martin Blumenstingl (1):
  clk: meson: meson8b: mark clk81 as critical

 drivers/clk/meson/gxbb.c    | 2 +-
 drivers/clk/meson/meson8b.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.9.4
