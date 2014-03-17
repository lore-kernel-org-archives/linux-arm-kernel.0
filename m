From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 17 Mar 2014 10:40:04 +0100
Subject: [PATCH RFC 0/5] Move tda998x to a couple encoder/connector
Message-ID: <cover.1395049204.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'slave encoder' structure of the tda998x driver asks for glue
between the DRM driver and the encoder/connector structures.

Changing the tda998x driver to a simple encoder/connector simplifies
the code of the tilcdc driver. This change is permitted by
Russell's infrastructure for componentised subsystems.

The proposed patch set does not include changes to the Armada DRM driver
which has no DT support yet and which will not work anymore if this
patch set is applied.

Jean-Francois Moine (5):
  drm/i2c: tda998x: Move tda998x to a couple encoder/connector
  drm/tilcdc: Change the interface with the tda998x driver
  drm/i2c: tda998x: Add required properties
  drm/tilcd: dts: Add the video sink
  ARM: AM33XX: dts: Change the tda998x description

 .../devicetree/bindings/drm/i2c/tda998x.txt        |  12 +
 .../devicetree/bindings/drm/tilcdc/slave.txt       |  18 -
 .../devicetree/bindings/drm/tilcdc/tilcdc.txt      |   6 +
 arch/arm/boot/dts/am335x-base0033.dts              |  28 +-
 arch/arm/boot/dts/am335x-boneblack.dts             |  21 +-
 drivers/gpu/drm/i2c/tda998x_drv.c                  | 335 +++++++++--------
 drivers/gpu/drm/tilcdc/Makefile                    |   1 -
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |  81 +++-
 drivers/gpu/drm/tilcdc/tilcdc_slave.c              | 406 ---------------------
 drivers/gpu/drm/tilcdc/tilcdc_slave.h              |  26 --
 10 files changed, 297 insertions(+), 637 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/drm/tilcdc/slave.txt
 delete mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave.c
 delete mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave.h

-- 
1.9.0
