From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 18 May 2012 15:01:10 -0600
Subject: Duplicate labels in dts files
Message-ID: <4FB6B896.3090904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following arch/arm/boot/dts/*.dts all have duplicate label
definitions, albeit all duplicates pointing at the same node. Is this
expected? This does work OK with the in-kernel dtc and latest mainline
dtc, but triggered some error-checks in a dtc patch that I have locally,
which allows node/property deletion. I think the duplicate labels should
probably be removed - do you agree?

at91sam9g25ek.dts
label: nand0
defined at at91sam9x5.dtsi:233
defined at at91sam9x5cm.dtsi:27

imx53-ard.dts
label: uart1
defined at imx53.dtsi:185
defined at imx53-ard.dts:43

imx6q-sabresd.dts
label: uart1
defined at imx6q.dtsi:168
defined at imx6q-sabresd.dts:28
