From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 29 Mar 2016 23:50:39 +0200
Subject: [PATCH 0/7] LPC18xx dts for 4.7
Message-ID: <1459288246-1670-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add support for the RTC and analog peripherals (ADC/DAC)
found on LPC18xx SoCs. It also adds a CREG clock controller which is
needed to enable the 1 kHz clock for the RTC. Note that the IIO drivers
and dt doc hasn't yet hit next but they are queued in the IIO tree and
should hit next anytime now.

There are also a few board updates to enable the analog peripherals
on the two LPC435x development boards.

These patches represent the bulk of dts additions on lpc18xx platform
for 4.7. There is also a bulk with warning fixes that is upcoming.

Joachim Eastwood (7):
  ARM: dts: lpc18xx: add creg-clk node
  ARM: dts: lpc18xx: add rtc node
  ARM: dts: lpc18xx: add adc nodes
  ARM: dts: lpc18xx: add dac node
  ARM: dts: lpc4357-ea4357: add adc0
  ARM: dts: lpc4357-ea4357: add dac
  ARM: dts: lpc4350-hitex-eval: add adc1

 arch/arm/boot/dts/lpc18xx.dtsi              | 43 ++++++++++++++++++++++++++++-
 arch/arm/boot/dts/lpc4350-hitex-eval.dts    | 23 +++++++++++++++
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts | 17 ++++++++++++
 3 files changed, 82 insertions(+), 1 deletion(-)

-- 
2.7.4
