From: andy.tang@nxp.com (Andy Tang)
Date: Wed, 7 Jun 2017 03:41:03 +0000
Subject: [PATCH] arm64: dts: ls1088a: update sata node
In-Reply-To: <20170607032611.GB31070@dragon>
References: <1496648752-27627-1-git-send-email-andy.tang@nxp.com>
 <20170605151441.GL4094@dragon>
 <HE1PR0402MB2828961E8052683E75B59D5CF3C80@HE1PR0402MB2828.eurprd04.prod.outlook.com>
 <20170607032611.GB31070@dragon>
Message-ID: <HE1PR0402MB2828FDB61A1AD186E3802962F3C80@HE1PR0402MB2828.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Please see my explanation below.

-----Original Message-----
From: Shawn Guo [mailto:shawnguo at kernel.org] 
Sent: Wednesday, June 07, 2017 11:26 AM
To: Andy Tang <andy.tang@nxp.com>
Cc: mark.rutland at arm.com; catalin.marinas at arm.com; robh+dt at kernel.org; will.deacon at arm.com; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH] arm64: dts: ls1088a: update sata node

On Wed, Jun 07, 2017 at 02:38:36AM +0000, Andy Tang wrote:
> Hi Shawn,
> 
> Please see the explanation below.
> 
> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Monday, June 05, 2017 11:15 PM
> To: Andy Tang <andy.tang@nxp.com>
> Cc: mark.rutland at arm.com; catalin.marinas at arm.com; 
> will.deacon at arm.com; robh+dt at kernel.org; 
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] arm64: dts: ls1088a: update sata node
> 
> On Mon, Jun 05, 2017 at 03:45:52PM +0800, Yuantian Tang wrote:
> > 1. Remove ls1043a compatible string from node
> 
> Can you explain a bit why the compatible string needs to be dropped?
> 
> A:  We thought ls1088 and ls1043 are 100% compatible in regard to sata.
> But actually, they are not because their ecc register address is different.

It's quite common that the same IP block is integrated into different SoCs with different register address.  That shouldn't be the reason for a new compatible.

A: ls1088 is not a new compatible. For ls1088 soc, it should be "fsl,ls1088a-ahci".
Previously, we thought ls1088 is compatible with ls1043, so that we defined compatible string as:  "fsl,ls1088a-ahci", "fsl,ls1043a-ahci"; By doing so, we can reuse code.

Now we found they are not 100% compatible because ECC register address is different. ECC register doesn't belong to SATA IP. It is a global register which controls many IPs. SATA ecc is controlled by only one bit in this register.

So we have to remove ls1043 compatible string from ls1088 sata node and make ls1088 sata node unique.

Thanks,
Andy

Shawn
