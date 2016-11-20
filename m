From: hao5781286@gmail.com (Hao Zhang)
Date: Sun, 20 Nov 2016 18:45:37 +0800
Subject: [PATCH v4 0/3] dmaengine: sun6i: add the support for the Allwinner
 A64 SOC.
Message-ID: <1479638740-20520-1-git-send-email-hao5781286@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Abort Allwinner A64 SOC :
Allwinner A64 (sun50i) 64bit  SoC features a Quad-Core Cortex-A53 ARM CPU, 
and a Mali400 MP2 GPU from ARM.

It has 8 channel DMA which flexible
data width of 8/16/32/64-bit. Detailed info about it is on
Allwinner_A64_User_Manual_V1.0 page 196 and A64_Datasheet_V1.1 page 8.

Document:
A64 Datasheet v1.1: http://files.pine64.org/doc/datasheet/pine64/A64_Datasheet_V1.1.pdf
A64 User Manual v1.0: http://files.pine64.org/doc/datasheet/pine64/Allwinner_A64_User_Manual_V1.0.pdf


Abort Pine64:
The Pine64 is a cost-optimized board with SOC A64 sporting ARMv8 (64-bit ARM) capable cores.
Detail info : 
https://linux-sunxi.org/Pine64 
http://wiki.pine64.org/index.php/Main_Page


PATCH LOG:
PATCH[v3,1/3]: https://patchwork.kernel.org/patch/9415765/
PATCH[v3,2/3]: https://patchwork.kernel.org/patch/9415761/
PATCH[V3,3/3]: https://patchwork.kernel.org/patch/9415761/

Changes in v4 :

PATCH[v4,1/3]:
Since PATCH[v3,1/3] has Acked-by  Maxime Ripard and Rob Herring
this is resend it.

PATCH[v4,2/3]:
Accept the comments from Maxime Ripard and add the dma nodes by
base adress, thinks!

PATCH[V4,3/3]:
Accept the hint from Maxime Ripard, add the 8 bytes bus width for
A64 dma and add the buswidth test, thinks!


It has test on Pine64 using dmatest.


Regards :)


Hao Zhang (3):
  Documentation: DT: add dma compatible for sun50i A64 SOC
  ARM64: dts: sun6i: add dma node for a64.
  dmaengine: sun6i: share the dma driver with sun50i

 .../devicetree/bindings/dma/sun6i-dma.txt          |  1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |  9 ++++++
 drivers/dma/sun6i-dma.c                            | 33 +++++++++++++++++++++-
 3 files changed, 42 insertions(+), 1 deletion(-)

-- 
2.7.4
