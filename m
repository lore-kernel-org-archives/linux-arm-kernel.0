From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 30 Jun 2014 16:07:39 +0200
Subject: [GIT PULL 1/2] ARM: berlin: DT changes for v3.17
Message-ID: <1404137260-5876-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

this cycle I try some incremental PRs for Berlin. This is round 1 of DT
related changes for Berlin SoCs.

We finally have a contribution directly from Marvell, let's hope they
will continue to provide patches. Then there is DW i2c nodes for BG2Q
and it's dev board and most notably SMP related nodes for BG2 and BG2Q.

Also, thanks to Jason and David, I now have some git space on infradead,
so the URL below represents that now.

Please pull.

Thanks,
  Sebastian

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-dt-3.17-1

for you to fetch changes up to d19c93670a3dc6d8b37a3256f20eeafff5417f93:

  ARM: dts: berlin: add SMP related nodes and properties for BG2Q (2014-06-16 13:17:53 +0200)

----------------------------------------------------------------
Berlin DT changes for v3.17

- L2CC latency properties for BG2Q
- DW i2c nodes for BG2Q and corresponding dev board
- SMP related nodes for BG2 and BG2Q

----------------------------------------------------------------
Antoine T?nart (6):
      ARM: dts: berlin: add I2C nodes for BG2Q
      ARM: dts: berlin: enable i2c0 and i2c2
      Documentation: bindings: add the Berlin CPU control doc
      Documentation: bindings: add the marvell,berlin-smp CPU enable method
      ARM: dts: berlin: add SMP related nodes and properties for BG2
      ARM: dts: berlin: add SMP related nodes and properties for BG2Q

Jisheng Zhang (1):
      ARM: dts: berlin2q: set L2CC tag and data latency to 2 cycles

 .../arm/cpu-enable-method/marvell,berlin-smp       | 41 +++++++++++
 .../devicetree/bindings/arm/marvell,berlin.txt     | 16 +++++
 arch/arm/boot/dts/berlin2.dtsi                     |  6 ++
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts         |  8 +++
 arch/arm/boot/dts/berlin2q.dtsi                    | 80 ++++++++++++++++++++++
 5 files changed, 151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cpu-enable-method/marvell,berlin-smp
