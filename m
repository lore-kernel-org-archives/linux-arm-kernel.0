From: andy.tang@nxp.com (Andy Tang)
Date: Wed, 7 Jun 2017 06:10:34 +0000
Subject: [PATCH] arm64: dts: ls1088a: update sata node
In-Reply-To: <20170607060224.GE31070@dragon>
References: <1496648752-27627-1-git-send-email-andy.tang@nxp.com>
 <20170605151441.GL4094@dragon>
 <HE1PR0402MB2828961E8052683E75B59D5CF3C80@HE1PR0402MB2828.eurprd04.prod.outlook.com>
 <20170607032611.GB31070@dragon>
 <HE1PR0402MB2828FDB61A1AD186E3802962F3C80@HE1PR0402MB2828.eurprd04.prod.outlook.com>
 <20170607060224.GE31070@dragon>
Message-ID: <HE1PR0402MB28286EA5AD30E856314E5E8CF3C80@HE1PR0402MB2828.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Yes, if there is a node in dts for ecc register/global register, we only need a phandler. Unfortunately,  ecc register actually is a hidden register.
If it were not for a sata workaround, we don't need to touch this register.

Thanks for your understanding.

Regards
Andy
 

-----Original Message-----
From: Shawn Guo [mailto:shawnguo at kernel.org] 
Sent: Wednesday, June 07, 2017 2:02 PM
To: Andy Tang <andy.tang@nxp.com>
Cc: mark.rutland at arm.com; catalin.marinas at arm.com; robh+dt at kernel.org; will.deacon at arm.com; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH] arm64: dts: ls1088a: update sata node

On Wed, Jun 07, 2017 at 03:41:03AM +0000, Andy Tang wrote:
> A: ls1088 is not a new compatible. For ls1088 soc, it should be "fsl,ls1088a-ahci".

Have you added the compatible support into kernel driver and bindings doc?

> Previously, we thought ls1088 is compatible with ls1043, so that we defined compatible string as:  "fsl,ls1088a-ahci", "fsl,ls1043a-ahci"; By doing so, we can reuse code.
> 
> Now we found they are not 100% compatible because ECC register address is different. ECC register doesn't belong to SATA IP. It is a global register which controls many IPs. SATA ecc is controlled by only one bit in this register.
> 

Okay, understood.  It sounds like the register should belong to a global system controller.  If the SATA driver was designed to parse the ECC register and bit from device tree with a phandle pointing to that system controller, we do not need to have so many compatibles for the same SATA IP.

Shawn
