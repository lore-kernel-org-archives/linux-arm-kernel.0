From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 12 Dec 2017 09:24:33 +0100
Subject: [PATCH 0/3] arm64: dts: renesas: r8a7796: cleanup of make dtb W=1
Message-ID: <20171212082436.12210-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series makes make dtb W=1 builds clean.

Patch 1 sorts subnodes of the root node into alphabetical order
to... well bring some order to things.

Patch 2 moves nodes without reg properties out of the SoC bus,
this is in keeping with recent work for the r8a7795 SoC.

Patch 3 adds reg property to the place holder peciec[01] nodes

Et voil?, make dtb W=1 no longer emits warnings.

$ aarch64-linux-gnu-gcc --version
aarch64-linux-gnu-gcc (Linaro GCC 5.4-2017.05) 5.4.1 20170404
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


Based on renesas-devel-20171211-v4.15-rc3

Simon Horman (3):
  arm64: dts: renesas: r8a7796: sort subnodes of root node
    alphabetically
  arm64: dts: renesas: r8a7796: move nodes which have no reg property
    out of bus
  arm64: dts: renesas: r8a7796: add reg properties to pciec[01] nodes

 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 216 ++++++++++++++++---------------
 1 file changed, 111 insertions(+), 105 deletions(-)

-- 
2.11.0
