From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 26 Nov 2018 11:34:38 +0100
Subject: [GIT PULL] arm: mediatek: DT fixes for v4.20
Message-ID: <d131fdd3-663c-9a5b-4296-94f2635f8c41@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,
Hi Arnd,

There two issues with the mt7622 based boards in the current v4.20-rc cycle.
Could you please pull the following fixes for the issues.

Thanks,
Matthias
----

The following changes since commit 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6:

  Linux 4.20-rc3 (2018-11-18 13:33:44 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
tags/v4.19-next-fixes

for you to fetch changes up to ce68cc6fad893eb33b69ef7ec186233a51696236:

  arm64: dts: mt7622: Drop the general purpose timer node (2018-11-26 11:19:19
+0100)

----------------------------------------------------------------
DT mt7622:
- kernelci awaits a working stdout-path.
  Fix the path for reference board and bananapi-r64
- general propouse timer has issues with clocks that didn't
  get probed early. Delete the DT node as the timer isn't
  need, a ARM arch timer exists on the system.

----------------------------------------------------------------
Ryder Lee (3):
      arm64: dts: mt7622: fix no more console output on rfb1
      arm64: dts: mt7622: fix no more console output on BPI-R64 board
      arm64: dts: mt7622: Drop the general purpose timer node

 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts |  7 ++++++-
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts             |  7 ++++++-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi                 | 10 ----------
 3 files changed, 12 insertions(+), 12 deletions(-)
