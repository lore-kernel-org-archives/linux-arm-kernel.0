From: rogershimizu@gmail.com (Roger Shimizu)
Date: Sat,  6 Feb 2016 14:59:50 +0900
Subject: [PATCH v2 0/3] fix and new support for orion5x based linkstation
In-Reply-To: <1454689998-9579-1-git-send-email-rogershimizu@gmail.com>
References: <1454689998-9579-1-git-send-email-rogershimizu@gmail.com>
Message-ID: <1454738393-14114-1-git-send-email-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Orion5x Maintainer,

Here're fix and new support for orion5x based linkstation devices.

Firstly, it add the missing mtd flash support, which I consider a fix
and can be backported to stable kernels, so I made the patch explicit.

Second, like the changes I made for kirkwood based linkstation DT,
I split the orion5x-linkstation-lswtgl.dts file into common and device
specific part, in order to support more devices.

Third, so there's a new device.

Hope this can be kindly accepted. Thank you!

Changes in v2:
- add "Fixes" tag for patch 1/3
- add "mvebu-" prefix to common .dtsi file to share between orion5x
  and kirkwood, which address comment from Andrew Lunn
- add "Reviewed-by" tag from Andrew Lunn for all 3 patches

Cheers,
Roger

Roger Shimizu (3):
  ARM: dts: orion5x: fix the missing mtd flash on linkstation lswtgl
  ARM: dts: orion5x: split linkstation lswtgl into common and device
    parts
  ARM: dts: orion5x: add device tree for buffalo linkstation ls-gl

 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/mvebu-linkstation-fan.dtsi       |  72 +++++++
 .../boot/dts/mvebu-linkstation-gpio-simple.dtsi    | 105 ++++++++++
 arch/arm/boot/dts/orion5x-linkstation-lsgl.dts     |  87 +++++++++
 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts   | 214 +++++----------------
 arch/arm/boot/dts/orion5x-linkstation.dtsi         | 180 +++++++++++++++++
 6 files changed, 491 insertions(+), 168 deletions(-)
 create mode 100644 arch/arm/boot/dts/mvebu-linkstation-fan.dtsi
 create mode 100644 arch/arm/boot/dts/mvebu-linkstation-gpio-simple.dtsi
 create mode 100644 arch/arm/boot/dts/orion5x-linkstation-lsgl.dts
 create mode 100644 arch/arm/boot/dts/orion5x-linkstation.dtsi

-- 
2.1.4
