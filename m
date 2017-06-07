From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 7 Jun 2017 14:02:26 +0800
Subject: [PATCH] arm64: dts: ls1088a: update sata node
In-Reply-To: <HE1PR0402MB2828FDB61A1AD186E3802962F3C80@HE1PR0402MB2828.eurprd04.prod.outlook.com>
References: <1496648752-27627-1-git-send-email-andy.tang@nxp.com>
 <20170605151441.GL4094@dragon>
 <HE1PR0402MB2828961E8052683E75B59D5CF3C80@HE1PR0402MB2828.eurprd04.prod.outlook.com>
 <20170607032611.GB31070@dragon>
 <HE1PR0402MB2828FDB61A1AD186E3802962F3C80@HE1PR0402MB2828.eurprd04.prod.outlook.com>
Message-ID: <20170607060224.GE31070@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 07, 2017 at 03:41:03AM +0000, Andy Tang wrote:
> A: ls1088 is not a new compatible. For ls1088 soc, it should be "fsl,ls1088a-ahci".

Have you added the compatible support into kernel driver and bindings
doc?

> Previously, we thought ls1088 is compatible with ls1043, so that we defined compatible string as:  "fsl,ls1088a-ahci", "fsl,ls1043a-ahci"; By doing so, we can reuse code.
> 
> Now we found they are not 100% compatible because ECC register address is different. ECC register doesn't belong to SATA IP. It is a global register which controls many IPs. SATA ecc is controlled by only one bit in this register.
> 

Okay, understood.  It sounds like the register should belong to a global
system controller.  If the SATA driver was designed to parse the ECC
register and bit from device tree with a phandle pointing to that
system controller, we do not need to have so many compatibles for the
same SATA IP.

Shawn
