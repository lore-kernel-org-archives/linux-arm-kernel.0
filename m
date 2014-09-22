From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 23 Sep 2014 00:41:25 +0200
Subject: [GIT PULL] ARM: berlin: DT changes for v3.18
In-Reply-To: <1411425685-27276-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1411425685-27276-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1411425685-27276-3-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Antoine is still working on GenPHY support for ChipIdea USB, but at least
AHCI support made it in. Also, there is reset bindings and corresponding
changes. Finally, enable a second timer on BG2Q.

Please pull,

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-dt-for-3.18-1

for you to fetch changes up to 7e782845040985ab7e431682505ddb419bc1d701:

  ARM: dts: berlin: enable timer 1 for sched_clock (2014-09-11 23:06:29 +0200)

----------------------------------------------------------------
Great work again from Antoine, adding AHCI nodes to BG2Q. This also
contains reset binding docs and corresponding dtsi additions. Last
patch enables a second timer on BG2Q used for sched_clock.

----------------------------------------------------------------
Antoine Tenart (3):
      Documentation: bindings: add reset bindings docs for Marvell Berlin SoCs
      ARM: dts: berlin: add a required reset property in the chip controller node
      ARM: dts: berlin: enable timer 1 for sched_clock

Antoine T?nart (2):
      ARM: berlin: add the AHCI node for the BG2Q
      ARM: berlin: enable the eSATA interface on the BG2Q DMP

 .../devicetree/bindings/arm/marvell,berlin.txt     | 10 ++++++
 arch/arm/boot/dts/berlin2.dtsi                     |  1 +
 arch/arm/boot/dts/berlin2cd.dtsi                   |  1 +
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts         |  8 +++++
 arch/arm/boot/dts/berlin2q.dtsi                    | 41 +++++++++++++++++++++-
 5 files changed, 60 insertions(+), 1 deletion(-)
