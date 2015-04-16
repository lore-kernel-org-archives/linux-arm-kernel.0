From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 16 Apr 2015 21:59:38 +0800
Subject: [query] how to use "ranges" in device tree
Message-ID: <20150416215938.347caa68@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I didn't fully understand the "ranges" usage, here is one situation which I dunno
how to handle.

In arch/arm/boot/dts/berlin2q.dtsi, we describe the /soc ranges as

ranges = <0 0xf7000000 0x1000000>;

That's fine. Now there's a pci device based on pcie-designware.c which prefer
put "config" space in reg. But the config space starts at 0xe0000000, due to
the /soc ranges, the "config" space following pcie node is not correct in fact.

soc {
	ranges = <0 0xf7000000 0x1000000>;
	...
	pcie: pcie at e40000 {
		compatible = "...";
		reg = <0xe40000 0x10000>, <0xe0000000 0x8000000>;
		reg-names = "dbi", "pad", "config";
		...
	};
	...
};

How to define the "config" space in this situation? Did we need to change
the /soc ranges as the following?

soc {
	ranges;
}

Thanks in advance,
Jisheng
