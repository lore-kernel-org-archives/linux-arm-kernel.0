From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 13 Aug 2017 17:11:28 +0200
Subject: [PATCH 0/4] DRM driver for Faraday TVE200
Message-ID: <20170813151132.24736-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I finally got my act together to clean up my patches and post
this DRM driver.

It's an old hardware, but using all the new fancy CMA helpers
and integrating really nicely I think. Most important: it
JustWorks(TM) and i have a little penguin and interactive
console on my D-Link DIR-685 router (!). Well that is not
a serious usecase, but it kind of proves that it does all it
should. Vblank interrupts work like a charm and all.

It would not have been possible if I hadn't had Eric Anholts
excellent PL11x driver to use as role model.

Daniel, Eric: please help me out with the next steps in your
maintenance model, so I learn how to do this upstream work
right with the DRM community.

I posted the display driver separately since it is, well
a separate business. I guess Thierry collects these drivers,
else tell me.

Linus Walleij (4):
  drm/tve200: Add DT bindings
  drm/tve200: Add new driver for TVE200
  ARM: dts: Add TVE200 to the Gemini SoC DTSI
  ARM: dts: Add TVE/TVC and ILI9322 panel to DIR-685

 .../devicetree/bindings/display/faraday,tve200.txt |  41 +++
 Documentation/gpu/index.rst                        |   1 +
 Documentation/gpu/tve200.rst                       |   6 +
 MAINTAINERS                                        |   6 +
 arch/arm/boot/dts/gemini-dlink-dir-685.dts         |  77 ++++-
 arch/arm/boot/dts/gemini.dtsi                      |  19 ++
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/tve200/Kconfig                     |  15 +
 drivers/gpu/drm/tve200/Makefile                    |   5 +
 drivers/gpu/drm/tve200/tve200_connector.c          | 126 ++++++++
 drivers/gpu/drm/tve200/tve200_display.c            | 346 +++++++++++++++++++++
 drivers/gpu/drm/tve200/tve200_drm.h                | 129 ++++++++
 drivers/gpu/drm/tve200/tve200_drv.c                | 277 +++++++++++++++++
 14 files changed, 1050 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/faraday,tve200.txt
 create mode 100644 Documentation/gpu/tve200.rst
 create mode 100644 drivers/gpu/drm/tve200/Kconfig
 create mode 100644 drivers/gpu/drm/tve200/Makefile
 create mode 100644 drivers/gpu/drm/tve200/tve200_connector.c
 create mode 100644 drivers/gpu/drm/tve200/tve200_display.c
 create mode 100644 drivers/gpu/drm/tve200/tve200_drm.h
 create mode 100644 drivers/gpu/drm/tve200/tve200_drv.c

-- 
2.13.4
