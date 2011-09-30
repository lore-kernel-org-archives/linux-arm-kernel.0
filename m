From: tony@atomide.com (Tony Lindgren)
Date: Fri, 30 Sep 2011 14:16:28 -0700
Subject: [GIT PATCH] OMAP: Add initial support for DT on OMAP3 & OMAP4
In-Reply-To: <4E86298E.4080007@ti.com>
References: <4E86298E.4080007@ti.com>
Message-ID: <20110930211628.GO6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Cousson, Benoit <b-cousson@ti.com> [110930 13:08]:
> Hi Tony,
> 
> Please pull the initial OMAP device tree support for  v3.2.

Great, thanks. And thanks for updating the two patches below
to say ARM: OMAP2+: in the subject :)

This is now in dt branch. Will merge into linux-omap master
branch and send all the dt changes to Arnd within few days.

Regards,

Tony


 
> Thanks,
> Benoit
> 
> 
> The following changes since commit 1c3543a34a8ce3e050d7706135bdffd5921c42f5:
>   Tony Lindgren (1):
>         Merge branch 'for_3.2/omap_device-2' of git://github.com/khilman/linux-omap-pm into dt
> 
> are available in the git repository at:
> 
>   git://gitorious.org/omap-pm/linux.git for_3.2/3_omap_devicetree
> 
> Benoit Cousson (10):
>       arm/dts: Add initial device tree support for OMAP4 SoC
>       arm/dts: Add support for OMAP4 PandaBoard
>       arm/dts: Add support for OMAP4 SDP board
>       arm/dts: Add initial device tree support for OMAP3 SoC
>       arm/dts: Add support for OMAP3 Beagle board
>       OMAP2+: board-generic: Add DT support to generic board
>       OMAP2+: board-generic: Add i2c static init
>       OMAP2+: l3-noc: Add support for device-tree
>       arm/dts: OMAP4: Add a main ocp entry bound to l3-noc driver
>       arm/dts: OMAP3+: Add mpu, dsp and iva nodes
> 
>  Documentation/devicetree/bindings/arm/omap/dsp.txt |   14 ++
>  Documentation/devicetree/bindings/arm/omap/iva.txt |   19 +++
>  .../devicetree/bindings/arm/omap/l3-noc.txt        |   19 +++
>  Documentation/devicetree/bindings/arm/omap/mpu.txt |   27 ++++
>  arch/arm/boot/dts/omap3-beagle.dts                 |   29 ++++
>  arch/arm/boot/dts/omap3.dtsi                       |   63 ++++++++
>  arch/arm/boot/dts/omap4-panda.dts                  |   29 ++++
>  arch/arm/boot/dts/omap4-sdp.dts                    |   29 ++++
>  arch/arm/boot/dts/omap4.dtsi                       |  103 +++++++++++++
>  arch/arm/mach-omap2/Kconfig                        |    8 +-
>  arch/arm/mach-omap2/board-generic.c                |  156 +++++++++++++++-----
>  arch/arm/mach-omap2/devices.c                      |    5 +
>  arch/arm/mach-omap2/omap_l3_noc.c                  |   23 +++-
>  arch/arm/mach-omap2/pm.c                           |    3 +-
>  14 files changed, 480 insertions(+), 47 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/dsp.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/iva.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/l3-noc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/mpu.txt
>  create mode 100644 arch/arm/boot/dts/omap3-beagle.dts
>  create mode 100644 arch/arm/boot/dts/omap3.dtsi
>  create mode 100644 arch/arm/boot/dts/omap4-panda.dts
>  create mode 100644 arch/arm/boot/dts/omap4-sdp.dts
>  create mode 100644 arch/arm/boot/dts/omap4.dtsi
