From: bhupesh.sharma@freescale.com (bhupesh.sharma at freescale.com)
Date: Fri, 27 Feb 2015 11:13:08 +0000
Subject: GICv3: Support for active low level-sensitive PPIs in device-tree
 binding
Message-ID: <BY1PR0301MB1303EF578091444B2C5CA3AD82150@BY1PR0301MB1303.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

While the GICv2 device-tree binding document (see [1]) seems to have support for active low level-sensitive PPIs:

The 3rd cell is the flags, encoded as follows:
	bits[3:0] trigger type and level flags.
		1 = low-to-high edge triggered
		2 = high-to-low edge triggered (invalid for SPIs)
		4 = active high level-sensitive
		8 = active low level-sensitive (invalid for SPIs).

The GICv3 device-tree bindings (see [2]) on the other hand, seem to be lacking the same for active low level-sensitive PPIs:

  The 3rd cell is the flags, encoded as follows:
	bits[3:0] trigger type and level flags.
		1 = edge triggered
		4 = level triggered

One of our SoC, supports active low level-sensitive PPIs on GICv3. If I spin-out a patch to address the same in GICv3 bindings,
will that be acceptable, or, is something on similar lines already in-work.

[1] https://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/tree/Documentation/devicetree/bindings/arm/gic.txt?h=for-next 

[2] https://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/tree/Documentation/devicetree/bindings/arm/gic-v3.txt?h=for-next

Regards,
Bhupesh
