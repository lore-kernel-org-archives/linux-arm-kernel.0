From: peda@axentia.se (Peter Rosin)
Date: Wed, 21 Mar 2018 16:35:49 +0100
Subject: [PATCH 0/3] ARM: dts: at91: cleanup pullup on uarts
Message-ID: <20180321153552.29213-1-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I noticed a *LOT* of pointless pullups and missing pullups related
to uart/usart pins. These patches fixes what I found.

I separated out the two changes that had pullup on neither rx nor tx,
since there might exist some reason for that? But a pullup on tx and
a missing pullup on rx is a sure sign of confusion, so I lumped all
those fixes in one big patch.

One or two of the removed comments with duplicate info where wrong
as well, i.e. the info was supposed to be duplicate but wasn't.

Cheers,
Peter

Peter Rosin (3):
  ARM: dts: at91: fixes uart pinctrl, set pullup on rx, clear pullup on
    tx
  ARM: dts: at91rm9200: pullup rx on uart0
  ARM: dts: at91sam9260: pullup rx on usart0

 arch/arm/boot/dts/at91rm9200.dtsi        | 16 ++++++++--------
 arch/arm/boot/dts/at91sam9260.dtsi       | 24 ++++++++++++------------
 arch/arm/boot/dts/at91sam9261.dtsi       | 12 ++++++------
 arch/arm/boot/dts/at91sam9263.dtsi       | 12 ++++++------
 arch/arm/boot/dts/at91sam9g45.dtsi       | 16 ++++++++--------
 arch/arm/boot/dts/at91sam9n12.dtsi       |  4 ++--
 arch/arm/boot/dts/at91sam9rl.dtsi        | 12 ++++++------
 arch/arm/boot/dts/at91sam9x5.dtsi        | 12 ++++++------
 arch/arm/boot/dts/at91sam9x5_usart3.dtsi |  4 ++--
 arch/arm/boot/dts/sama5d3.dtsi           | 24 ++++++++++++------------
 arch/arm/boot/dts/sama5d3_uart.dtsi      |  8 ++++----
 arch/arm/boot/dts/sama5d4.dtsi           | 28 ++++++++++++++--------------
 12 files changed, 86 insertions(+), 86 deletions(-)

-- 
2.11.0
