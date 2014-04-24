From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Thu, 24 Apr 2014 12:33:11 +0100
Subject: "magic" handling of memory nodes
Message-ID: <20140424113311.GR5904@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Following on the special handling of nodes called memory at 0, I went to
have a look at the various platforms that do not actually declare a
device_type = "memory" for their "memory" nodes.

Firstly, we currently have 162(ish, I did a sloppy grep) such .dts{i}
files in the kernel tree.

Secondly, the only reason these platforms could ever have worked is
because they include .dtsi files that define a memory node with a
type explicitly set. Since this node already exists, its contents get
overridden, but the type tag remains. Of course, this only happens
with nodes called explicitly "memory" - but it happens regardless of
what other things they contain.

In the ARM tree, most of these seem to stem from the inclusion of
skeleton.dtsi.

I don't really know what could/should be done about this, but it
does not feel optimal.

/
	Leif
