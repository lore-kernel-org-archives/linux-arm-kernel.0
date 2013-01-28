From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 28 Jan 2013 17:54:20 +0200
Subject: [PATCH 0/2] Table lookup for mux clock type
Message-ID: <1359388467-32386-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds a table lookup feature to the mux clock type. This will
be used by the forthcoming Tegra114 clock implementation. Also instead of
a fixed field width, a mask is used. This is because Tegra114 has some muxes
where the parent selector is spread over several bitfields. The second patch
adapts the tegra periph clock implementation which uses struct clk_mux
directly.

Peter De Schrijver (2):
  clk: add table lookup to mux
  clk: tegra: adapt tegra periph clk to mux table/mask

 drivers/clk/clk-mux.c        |   51 ++++++++++++++++++++++++++++++++---------
 drivers/clk/tegra/clk.h      |   27 +++++++++++++++------
 include/linux/clk-private.h  |    3 +-
 include/linux/clk-provider.h |    9 ++++++-
 4 files changed, 69 insertions(+), 21 deletions(-)

-- 
1.7.7.rc0.72.g4b5ea.dirty
