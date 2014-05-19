From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 19 May 2014 16:40:49 +0300
Subject: pull request for Tegra clock fixes for 3.16
Message-ID: <20140519134049.GA20109@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

A number of fixes which are needed by the upcoming XHCI and SATA drivers.

Thanks,

Peter.

The following changes since commit d6d211db37e75de2ddc3a4f979038c40df7cc79c:

  Linux 3.15-rc5 (2014-05-09 13:10:52 -0700)

are available in the git repository at:
  git://nv-tegra.nvidia.com/user/pdeschrijver/linux.git tegra-clk-v3.16

Andrew Bresticker (2):
      clk: tegra: Fix xusb_hs_src clock hierarchy
      clk: tegra: Initialize xusb clocks

Jim Lin (2):
      clk: tegra: Enable hardware control of PLLE
      clk: tegra: Fix xusb_fs_src mux

 drivers/clk/tegra/clk-id.h               |    1 +
 drivers/clk/tegra/clk-pll.c              |   33 +++++++++++++++++++++++++++++-
 drivers/clk/tegra/clk-tegra-periph.c     |   10 ++++++++-
 drivers/clk/tegra/clk-tegra114.c         |   22 ++++++++++----------
 drivers/clk/tegra/clk-tegra124.c         |   21 ++++++++++---------
 include/dt-bindings/clock/tegra114-car.h |    3 +-
 include/dt-bindings/clock/tegra124-car.h |    3 +-
 7 files changed, 68 insertions(+), 25 deletions(-)
