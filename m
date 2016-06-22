From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 22 Jun 2016 12:43:38 +0900
Subject: [PATCH v3 00/13] ARM: dts: r8a779x: use demuxer for I2C
Message-ID: <1466567031-20381-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the intention of this series is to extend use of the demuxer for I2C
on the lager, koelsch, porter, koelsch, alt and silk boards  cover all I2C IP
blocks that are either already used or exposed via an EXIO connector.

* This is based on work by Wolfram Sang.
* Testing:
  - Underlying driver problems are discussed in the thread
    "[PATCH v2 0/4] ARM: dts: r8a7790: lager: use demuxer for I2C"
  - I have only compile tested the silk and porters patches as I do
    not have access to those boards
  - For all other boards I have boot tested the code and the
    the default settings seem to work.
* This series is based on renesas-next-20160621-v4.7-rc1
* To aid review it is provided in git at:
  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/i2c-demu x-v3
* I also intend to add demux for I2C for r8a7792/blanche

Changes between v2 and v3
* Group extra GPIO buses
* Add GPIO fallback for IIC1/I2C1 on Lager
* Add patches for koelsch, porter, alt and silk

Changes between v1 and v2
* Provide GPIO fallback for I2C2,
  this does not seem appropriate for other I2C blocks on the lager board

Simon Horman (13):
  ARM: dts: lager: rename and reindex i2cexio
  ARM: dts: lager: use demuxer for IIC1/I2C1
  ARM: dts: lager: use demuxer for IIC2/I2C2
  ARM: dts: lager: use demuxer for IIC3/I2C3
  ARM: dts: koelsch: use demuxer for I2C1
  ARM: dts: koelsch: use demuxer for I2C2
  ARM: dts: koelsch: use demuxer for I2C4
  ARM: dts: porter: use demuxer for I2C2
  ARM: dts: porter: use demuxer for I2C2
  ARM: dts: koelsch: use demuxer for I2C4
  ARM: dts: alt: use demuxer for I2C1
  ARM: dts: alt: use demuxer for I2C4
  ARM: dts: silk: use demuxer for I2C1

 arch/arm/boot/dts/r8a7790-lager.dts   | 275 +++++++++++++++++++++++-----------
 arch/arm/boot/dts/r8a7791-koelsch.dts | 209 +++++++++++++++++++-------
 arch/arm/boot/dts/r8a7791-porter.dts  | 129 +++++++++-------
 arch/arm/boot/dts/r8a7793-gose.dts    | 147 ++++++++++++------
 arch/arm/boot/dts/r8a7794-alt.dts     |  87 +++++++++--
 arch/arm/boot/dts/r8a7794-silk.dts    | 117 +++++++++------
 6 files changed, 658 insertions(+), 306 deletions(-)

-- 
2.1.4
