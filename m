From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jan 2013 01:29:43 +0000
Subject: [GIT PULL] ARM: mvebu fixes for v3.8-rc5
Message-ID: <1358904583.07bA7B0.11715@triton>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 11d5993df2e1f65e3acfeb92a3febe88803b3e7f:

  arm: mvebu: Fix memory size for Armada 370 DB (2013-01-10 19:16:51 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/mvebu_fixes_for_v3.8-rc5

for you to fetch changes up to 09d75bc7d217bd8868899028a98b53423e6b3324:

  ARM: kirkwood: fix missing #interrupt-cells property (2013-01-23 01:10:48 +0000)

----------------------------------------------------------------
mvebu fixes for v3.8-rc5
 - fix memory leak in mvebu/clk-cpu.c
 - use devm_ to correct/simplify error paths in mvsdio
 - add missing #interrupt-cells property in kirkwood

----------------------------------------------------------------
Andrew Lunn (1):
      mmc: mvsdio: use devm_ API to simplify/correct error paths.

Cong Ding (1):
      clk: mvebu/clk-cpu.c: fix memory leakage

Sebastian Hesselbarth (1):
      ARM: kirkwood: fix missing #interrupt-cells property

 arch/arm/boot/dts/kirkwood.dtsi |  2 +
 drivers/clk/mvebu/clk-cpu.c     |  9 ++--
 drivers/mmc/host/mvsdio.c       | 92 ++++++++++++++---------------------------
 3 files changed, 38 insertions(+), 65 deletions(-)
