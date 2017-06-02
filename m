From: khilman@baylibre.com (Kevin Hilman)
Date: Fri,  2 Jun 2017 16:43:58 -0700
Subject: [PATCH/RFT 0/3] ARM: davinci: da850-evm: camera capture
Message-ID: <20170602234401.24721-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is the final step to demonstrate VPIF capture via an
external camera sensor.  It is only FYI and for testing/validation
purposes, and not intended for upstream merge.

Tested on a da850-evm with UI board.

With only the first patch (GPIO hogs) patch applied, VPIF capture
works for composite input, but still relies on pdata-quirks for the
tvp514x input/output routing.

With the rest of the series applied, it works for camera input with
VPIF in DT mode (no more pdata-quirks needed.)  

Tested with da850-evm + UI board + On-Semi camera board using
aptina,mt9v032 sensor:
  http://www.mouser.com/search/ProductDetail.aspx?R=0virtualkey0virtualkeyMT9V032C12STCH-GEVB

Dependencies:
- VPIF driver changes
  https://marc.info/?l=linux-arm-kernel&m=149643932427173
- davinci platform updates
  https://marc.info/?l=linux-arm-kernel&m=149644517728393

Kevin Hilman (3):
  ARM: dts: da850-evm: VPIF input selction via GPIO hogs
  ARM: dts: da850-evm.dts: add mt9v032 camera sensor
  HACK: ARM: davinci: add cdce913 clock controller

 arch/arm/boot/dts/da850-evm.dts      |  76 ++++++++++++++++
 arch/arm/mach-davinci/Makefile       |   2 +-
 arch/arm/mach-davinci/cdce913.c      | 164 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-davinci/pdata-quirks.c |   8 +-
 4 files changed, 247 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-davinci/cdce913.c

-- 
2.9.3
