From: zonque@gmail.com (Daniel Mack)
Date: Tue, 19 Feb 2013 00:55:52 +0100
Subject: Question about fixed-clock
Message-ID: <5122BF88.1050007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This might be a stupid question, but I'm somehow stuck here. I'm using a
driver with the following DTS sub-node:

	ref25: ref25M {
		compatible = "fixed-clock";
		#clock-cells = <0>;
		clock-frequency = <25000000>;
	};

	clock-generator at 0 {
				/* ... */
				#clock-cells = <1>;
				clocks = <&ref25>;
	}

The device driver for clock-generator uses something like the following
call to get its clock:

	clk = of_clk_get(np, 0);

but the return value is ERR_PTR(-ENOENT) and I also can't find this
clock in the clk debugfs tree.

This is on a OMAP/AM33xx device with kernel 3.8-rc7 plus the -next tips
of arm-soc and omap, but with no other special clock options selected in
the config. Is there anything I'm missing to correctly instantiate the
dummy clock?


Thanks for a pointer,
Daniel
