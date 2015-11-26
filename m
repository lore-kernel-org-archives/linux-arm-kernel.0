From: slash.tmp@free.fr (Mason)
Date: Thu, 26 Nov 2015 14:16:16 +0100
Subject: Preprocessor arithmetic in dtsi files (base + offset)
Message-ID: <56570620.3070106@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

In the device tree for my ARM platform, I have several nodes with
addresses within the SCU block:

	scu: scu at 20000000 {
		compatible = "arm,cortex-a9-scu";
		reg = <0x20000000 0x100>;

	gic: interrupt-controller at 20001000 {
		compatible = "arm,cortex-a9-gic";
		reg = <0x20001000 0x1000>, <0x20000100 0x0100>;

	twd-timer at 20000600 {
		compatible = "arm,cortex-a9-twd-timer";
		reg = <0x20000600 0x10>;

Can I use preprocessor arithmetic to abstract the base address,
as would be done in C?

#define SCU_BASE 0x20000000

	scu: scu at XXX {
		compatible = "arm,cortex-a9-scu";
		reg = <SCU_BASE 0x100>;
	
	gic: interrupt-controller at XXX {
		compatible = "arm,cortex-a9-gic";
		reg = <SCU_BASE+0x1000 0x1000>, <SCU_BASE+0x100 0x0100>;

	twd-timer at XXX {
		compatible = "arm,cortex-a9-twd-timer";
		reg = <SCU_BASE+0x600 0x10>;

Are the @XXX important? Can they be removed altogether?

Regards.
