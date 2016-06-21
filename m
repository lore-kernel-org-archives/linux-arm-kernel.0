From: dhdang@apm.com (Duc Dang)
Date: Tue, 21 Jun 2016 16:40:49 -0700
Subject: [GIT PULL] arm64: X-Gene platforms DTS changes queued for 4.8 - part1
Message-ID: <CADaLNDmLXF3Y7bcabHzzu5eXXqQ8R98QUgO8yKTnCcqCRXPnDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This is the first part of DTS changes for X-Gene platforms targeted for 4.8

The changes includes
+ 2 clean-up and style fix from Bjorn with Rob's ACK [1]
+ A timer interrupt polarity fix for X-Gene 2 (refer to Marc's
arm/arm64 arch timer fix [2])
+ Clean up an unused clk node (qmlclk) for X-Gene 1

Marc's arch timer series [2] has a change in apm-storm.dtsi file. I
verified and the order of applying Marc's apm-storm.dtsi change and
the DT changes in xgene-next did not cause any conflict.

[1]: (https://lkml.org/lkml/2016/6/14/340
[2]: http://www.spinics.net/lists/linux-samsung-soc/msg53533.html

Regards,
Duc Dang.
------

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  https://github.com/AppliedMicro/xgene-next.git tags/xgene-dts-for-v4.8-part1

for you to fetch changes up to ddbc71d96012fbcc4b9e42fd1c131f185875f73f:

  arm64: dts: apm: Remove unused qmlclk node on X-Gene 1 (2016-06-20
18:41:49 -0700)

----------------------------------------------------------------
First part of X-Gene DTS changes queued for v4.8

The changes include:
+ 2 clean-up and style-fix patches from Bjorn
+ Correct timer interrupt polarity for X-Gene 2
+ Remove unused qmlclk node on X-Gene 1

----------------------------------------------------------------
Bjorn Helgaas (2):
      arm64: dts: apm: Use lowercase consistently for hex constants
      arm64: dts: apm: Remove leading '0x' from unit addresses

Duc Dang (2):
      arm64: dts: apm: Fix timer interrupt polarity for X-Gene 2 SoC
      arm64: dts: apm: Remove unused qmlclk node on X-Gene 1

 .../devicetree/bindings/net/apm-xgene-enet.txt     |  4 +-
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi         | 68 +++++++++++-----------
 arch/arm64/boot/dts/apm/apm-storm.dtsi             | 44 ++++++--------
 3 files changed, 53 insertions(+), 63 deletions(-)
