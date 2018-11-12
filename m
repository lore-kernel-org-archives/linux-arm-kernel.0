From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Nov 2018 13:31:12 +0100
Subject: [PATCH 0/3 v6] Switch Versatile Express to DRM
Message-ID: <20181112123115.6176-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This should finally (famous last words) switch the Versatile
Express to use the new PL111 DRM driver.

These changes depend on patches queued in the DRM tree,
so it should resolve nicely in -next, also you can probably
test them easiest by simply applying them on -next.

The DTS and defconfig changes should ideally come in
lockstep but I guess maybe the ARM maintainers want the
DTS changes in one branch and the defconfig updates in
another branch.

As long as they go in the same merge window all should
be fine, they should just be tested together (and with
the pending DRM changes).


Linus Walleij (3):
  ARM: dts: Modernize the Vexpress PL111 integration
  ARM: defconfig: Update the vexpress defconfig
  ARM: defconfig: Enable the PL111 DRM driver on vexpress

 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi       | 49 +++++----------
 arch/arm/boot/dts/vexpress-v2m.dtsi           | 63 +++++++++----------
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts   | 14 +++++
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts    | 14 +++++
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts       | 14 +++++
 arch/arm/boot/dts/vexpress-v2p-ca9.dts        | 43 ++++++-------
 arch/arm/configs/vexpress_defconfig           | 24 +++----
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts    | 23 +++++++
 .../boot/dts/arm/rtsm_ve-motherboard.dtsi     | 37 ++---------
 .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts | 14 +++++
 10 files changed, 158 insertions(+), 137 deletions(-)

-- 
2.17.2
