From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  2 Mar 2016 10:05:38 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Fixes for v4.5
Message-ID: <cover.1456880499.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC DT fixes for v4.5.

This pull request is based on the previous round of
such requests, tagged as renesas-dt-fixes-for-v4.5,
which you have already pulled.

If this pull-request is too late for v4.5 then please consider it for v4.6.


HS-USB DT support was added to the porter board in v4.5-rc1.
Unfortunately it was developed against an early revision of the
board and newer revisions do not include the Maxim Integrated MAX3355 OTG
chip and thus there should not be a renesas,enable-gpio property.

It is my understanding at this time that the early-revision boards in
question have not been observed in the wild.


The following changes since commit 8bc403b78ffb774d8dc944abb0826c46c0dca09d:

  ARM: dts: silk: Add compatible property to "partitions" node (2016-01-07 08:39:06 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-fixes2-for-v4.5

for you to fetch changes up to 949024d6702d1da8a266f42226d8402f0df078dc:

  ARM: dts: porter: remove enable prop from HS-USB device node (2016-03-02 09:46:56 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Fixes for v4.5

* remove enable prop from HS-USB device node on porter board

----------------------------------------------------------------
Sergei Shtylyov (1):
      ARM: dts: porter: remove enable prop from HS-USB device node

 arch/arm/boot/dts/r8a7791-porter.dts | 1 -
 1 file changed, 1 deletion(-)
