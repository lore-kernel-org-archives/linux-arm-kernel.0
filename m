From: slash.tmp@free.fr (Mason)
Date: Fri, 13 Nov 2015 10:33:50 +0100
Subject: Conditionals in dtsi files
Message-ID: <5645AE7E.4090003@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm wondering how much C preprocessor syntax one can use in DT files.

Suppose I have 2 board DTS (both including common.dtsi)

board_A.dts (1-core), board_B.dts (2-core)

Can I have in common.dtsi something along these lines:

	cpus {
		enable-method = "foo,bar";
		#address-cells = <1>;
		#size-cells = <0>;

		cpu0: cpu at 0 {
			compatible = "arm,cortex-a9";
			device_type = "cpu";
			reg = <0>;
		};

#if CORE_COUNT > 1
		cpu1: cpu at 1 {
			compatible = "arm,cortex-a9";
			device_type = "cpu";
			reg = <1>;
		};
#endif
	};


board_A.dts would have
#define CORE_COUNT 1
#include "common.dtsi"

board_B.dts would have
#define CORE_COUNT 2
#include "common.dtsi"

Regards.
