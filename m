From: w-kwok2@ti.com (Kwok, WingMan)
Date: Wed, 2 Sep 2015 15:31:18 +0000
Subject: [PATCH] ARM: dts: keystone: use one to one address translations
 under netcp
In-Reply-To: <55E61658.9010207@oracle.com>
References: <1441139324-29296-1-git-send-email-w-kwok2@ti.com>
 <55E61658.9010207@oracle.com>
Message-ID: <230CBA6E4B6B6B418E8730AC28E6FC7E04221776@DFLE11.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: santosh.shilimkar at oracle.com [mailto:santosh.shilimkar at oracle.com]
> Sent: Tuesday, September 01, 2015 5:19 PM
> To: Kwok, WingMan; robh+dt at kernel.org; pawel.moll at arm.com;
> mark.rutland at arm.com; ijc+devicetree at hellion.org.uk; galak at codeaurora.org;
> linux at arm.linux.org.uk; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; ssantosh at kernel.org
> Cc: Karicheri, Muralidharan
> Subject: Re: [PATCH] ARM: dts: keystone: use one to one address translations
> under netcp
> 
> On 9/1/15 1:28 PM, WingMan Kwok wrote:
> > Network subsystem NetCP in Keystone-2 devices includes some HW blocks
> > that are memory mapped to ranges outside that of the NetCP itself.
> > Thus address space of a child node of the NetCP node needs to be
> > mapped 1:1 onto the parent address space.  Hence empty ranges
> > should be used under the NetCP node.
> >
> > Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> > ---
> >   arch/arm/boot/dts/k2e-netcp.dtsi  |    8 +++-----
> >   arch/arm/boot/dts/k2hk-netcp.dtsi |   14 ++++++--------
> >   arch/arm/boot/dts/k2l-netcp.dtsi  |    8 +++-----
> >   3 files changed, 12 insertions(+), 18 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/k2e-netcp.dtsi b/arch/arm/boot/dts/k2e-
> netcp.dtsi
> > index b13b3c9..e103ed9 100644
> > --- a/arch/arm/boot/dts/k2e-netcp.dtsi
> > +++ b/arch/arm/boot/dts/k2e-netcp.dtsi
> > @@ -111,9 +111,7 @@ netcp: netcp at 24000000 {
> >   	compatible = "ti,netcp-1.0";
> >   	#address-cells = <1>;
> >   	#size-cells = <1>;
> > -
> > -	/* NetCP address range */
> > -	ranges = <0 0x24000000 0x1000000>;
> > +	ranges;
> >
> What blocks are we talking here. We need to increase the
> range if the current range isn't covering entire NETCP
> address space. Removing range isn't a solution.
> 

The Serdes.  It is a HW block inside the NetCP but its address
space starts from 0x0232a000.  We can change the base in the
ranges property to include the serdes.  But then offsets of
other HW blocks that are within the NetCP address range will be
relative to this new base and are not as documented in the HW
user guides.

Regards
WingMan
