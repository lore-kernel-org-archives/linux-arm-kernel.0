From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Jun 2013 10:37:15 -0600
Subject: [GIT PULL 2/5] ARM: tegra: create headers for clock bindings
In-Reply-To: <1371227838-18764-1-git-send-email-swarren@wwwdotorg.org>
References: <1371227838-18764-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1371227838-18764-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Note that I don't believe that the drivers/clk changes that rely on this
branch were actually sent for this cycle, so this branch was probably
never pulled into the clk tree.)

This branch creates header files that define the clock IDs used by
Tegra's DT clock binding, and update the DT binding documentation to
refer to those files.

These changes are needed in both the Tegra tree, in order to update DT
files to use the new headers, and the clock tree, in order to update the
clock drivers to use the headers rather than defining their own enum for
the same purpose.

This branch is included in later pull request tegra-for-3.11-dt.

----------------------------------------------------------------

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.11-deps-for-clk

for you to fetch changes up to 992bb598f690542a2f539fd12a42b960b7692025:

  ARM: tegra114: create a DT header defining CLK IDs

----------------------------------------------------------------

Hiroshi Doyu (3):
      ARM: tegra20: create a DT header defining CLK IDs
      ARM: tegra30: create a DT header defining CLK IDs
      ARM: tegra114: create a DT header defining CLK IDs

 .../bindings/clock/nvidia,tegra114-car.txt      | 252 +-------------
 .../bindings/clock/nvidia,tegra20-car.txt       | 154 +--------
 .../bindings/clock/nvidia,tegra30-car.txt       | 211 +-----------
 include/dt-bindings/clock/tegra114-car.h        | 342 +++++++++++++++++++
 include/dt-bindings/clock/tegra20-car.h         | 158 +++++++++
 include/dt-bindings/clock/tegra30-car.h         | 265 ++++++++++++++
 6 files changed, 777 insertions(+), 605 deletions(-)
 create mode 100644 include/dt-bindings/clock/tegra114-car.h
 create mode 100644 include/dt-bindings/clock/tegra20-car.h
 create mode 100644 include/dt-bindings/clock/tegra30-car.h
