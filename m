From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  6 Mar 2014 00:27:10 +0800
Subject: [PATCH 0/5] ARM: sun6i: dt: Add support for GMAC
Message-ID: <1394036835-22007-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

This series add support for the GMAC in A31. The GMAC is the same as in
the A20, except it has an extra reset control. The GMAC clock module is
mostly the same as in the A20, without the extra dividers, which I left
out intentionally from the clock driver.

The register offsets and interrupts were copied from A31 SDK in Rhombus
Tech's repository. The pin muxes were from the EVB fex file. If you have
the A31 datasheet, you could double check them.

This series is based on current sunxi-next ( e8176a3b0 ).

As I don't have actual A31 hardware, this is only compile tested.
Please give it a try, and let me know if it works or not.


Cheers,
ChenYu


Chen-Yu Tsai (5):
  ARM: sun6i: dt: Add pin muxing options for GMAC
  ARM: sun6i: dt: Add GMAC clock node to the A31 DTSI
  ARM: sun6i: dt: Add A31 GMAC gigabit ethernet controller node
  ARM: sun6i: dt: Add ethernet alias for GMAC
  ARM: sun6i: columbus: Enable the GMAC

 arch/arm/boot/dts/sun6i-a31-colombus.dts | 12 +++++
 arch/arm/boot/dts/sun6i-a31.dtsi         | 87 ++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

-- 
1.9.0
