From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 25 Oct 2016 16:55:30 -0700
Subject: [RFC PATCH 0/6] media: davinci: VPIF: add DT support
Message-ID: <20161025235536.7342-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series attempts to add DT support to the davinci VPIF capture
driver.

I'm not sure I've completely grasped the proper use of the ports and
endpoints stuff, so this RFC is primarily to get input on whether I'm
on the right track.

The last patch is the one where all my questions are, the rest are
just prep work to ge there.

Tested on da850-lcdk and was able to do basic frame capture from the
composite input.

Series applies on v4.9-rc1

Kevin Hilman (6):
  [media] davinci: add support for DT init
  ARM: davinci: da8xx: VPIF: enable DT init
  ARM: dts: davinci: da850: add VPIF
  ARM: dts: davinci: da850-lcdk: enable VPIF capture
  [media] davinci: vpif_capture: don't lock over s_stream
  [media] davinci: vpif_capture: get subdevs from DT

 arch/arm/boot/dts/da850-lcdk.dts              |  30 ++++++
 arch/arm/boot/dts/da850.dtsi                  |  28 +++++
 arch/arm/mach-davinci/da8xx-dt.c              |  17 +++
 drivers/media/platform/davinci/vpif.c         |   9 ++
 drivers/media/platform/davinci/vpif_capture.c | 150 +++++++++++++++++++++++++-
 include/media/davinci/vpif_types.h            |   9 +-
 6 files changed, 236 insertions(+), 7 deletions(-)

-- 
2.9.3
