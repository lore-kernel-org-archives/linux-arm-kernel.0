From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 26 Feb 2018 12:35:33 +0800
Subject: [PATCH] arm64: dts: ls1046a: drop incomplete memory node
In-Reply-To: <AM4PR0401MB1699AD47DE96B4299F680E498FC10@AM4PR0401MB1699.eurprd04.prod.outlook.com>
References: <1519455896-8924-1-git-send-email-shawnguo@kernel.org>
 <AM4PR0401MB1699AD47DE96B4299F680E498FC10@AM4PR0401MB1699.eurprd04.prod.outlook.com>
Message-ID: <20180226043532.GT3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 01:33:34AM +0000, Leo Li wrote:
> 
> 
> > -----Original Message-----
> > From: Shawn Guo [mailto:shawnguo at kernel.org]
> > Sent: Saturday, February 24, 2018 3:05 PM
> > To: linux-arm-kernel at lists.infradead.org
> > Cc: devicetree at vger.kernel.org; Shawn Guo <shawnguo@kernel.org>;
> > Mingkai Hu <mingkai.hu@nxp.com>; Shaohui Xie <Shaohui.Xie@nxp.com>;
> > Leo Li <leoyang.li@nxp.com>
> > Subject: [PATCH] arm64: dts: ls1046a: drop incomplete memory node
> > 
> > The memory node in fsl-ls1046a.dtsi has no 'reg' property, and causes the
> > dtc warning below.
> > 
> > Warning (unit_address_vs_reg): Node /memory at 80000000 has a unit name,
> > but no reg property
> > 
> > This is clearly an incomplete memory node.  Let's drop it.  Either a complete
> > memory should be added, or bootloader needs to fill the node as a whole.
> 
> Or we can put in a dummy reg property to be updated by bootloader like the mac-address property?

Yeah, I'm fine with either way, as long as we get rid of the warning.
I will post v2 shortly.

Shawn
