From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 22 Nov 2016 11:45:47 -0800
Subject: [PATCH 0/4] ARM: davinci: add/enable video capture for da850-lcdk
Message-ID: <20161122194551.3420-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT description of da850 video capture (using VPIF) for the da850
SoC.  and the LCDK board.  This enables video capture using the
composite input on the LCDK board.

Series applies to Sekhar's v4.10/dt branch (and defconfig change will
have trivial add/add conflict when applied to Sekhar's defconfig branch.)

@Sekhar: I'm not sure if you want the first patch to go via your soc
branch or dt branch, but I kept it together with this series for now.
Feel free to break it up as needed.  It will also have a trivial
add/add conflict with some existing changes to that file.

Depenencies:
- [PATCH v3 0/4] [media] davinci: VPIF: add DT support
  https://marc.info/?l=devicetree&m=147982997317376&w=2

In video capture to work, this series depends on the above VPIF driver
update to enable DT support, however there are no build or boot-time
regressions if this series goes in independently of the driver
changes.  There will simply be no video capture support until the
driver changes are done (which the same as how things work today.)

Kevin Hilman (4):
  ARM: davinci: da8xx: VPIF: enable DT init
  ARM: dts: davinci: da850: add VPIF
  ARM: dts: davinci: da850-lcdk: enable VPIF capture via TVP5147
  ARM: davinci_all_defconfig: enable video capture as modules

 arch/arm/boot/dts/da850-lcdk.dts       | 30 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi           | 28 ++++++++++++++++++++++++++++
 arch/arm/configs/davinci_all_defconfig |  6 ++++++
 arch/arm/mach-davinci/da8xx-dt.c       | 17 +++++++++++++++++
 4 files changed, 81 insertions(+)

-- 
2.9.3
