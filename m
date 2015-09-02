From: amstan@chromium.org (Alexandru M Stan)
Date: Wed,  2 Sep 2015 16:27:57 -0700
Subject: [PATCH v2 0/2] ARM: dts: rockchip: pull up cts lines
Message-ID: <1441236479-4941-1-git-send-email-amstan@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flow control lines from a user accessible UART are optional,
the user might not have anything connected to those pins.
In order to prevent random interrupts happening and noise affecting
the cts pin should be pulled up.

The only boards affected (that care about uart*_cts ) are the veyron
chromeos devices and the firefly. Veyron already has something like that,
which I now have to remove in the second patch. Firefly uses uart0_cts
for the wifi chip communications, same thing as veyron, so it should be
fine having it.

Changes in v2:
- Restrict changes only to cts pin, leave rts alone
- CC people with the firefly board
- New patch removing redundant pullup code from veyron
- cover letter

Alexandru M Stan (2):
  ARM: dts: rockchip: pull up cts lines on rk3288
  ARM: dts: rockchip: Remove specific cts pullup from veyron

 arch/arm/boot/dts/rk3288-veyron.dtsi | 12 ------------
 arch/arm/boot/dts/rk3288.dtsi        |  8 ++++----
 2 files changed, 4 insertions(+), 16 deletions(-)

-- 
2.5.0.457.gab17608
