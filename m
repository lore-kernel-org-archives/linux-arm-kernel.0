From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Fri, 5 Aug 2016 06:48:51 +0000
Subject: [RFC PATCH v3 1/2] Documentation: DT: net: Add Xilinx
 gmiitorgmii converter device tree binding documentation
In-Reply-To: <20160804182515.GA19890@rob-hp-laptop>
References: <1470312789-28275-1-git-send-email-appanad@xilinx.com>
 <20160804182515.GA19890@rob-hp-laptop>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A5DD373@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

	Thanks for the review...

<Snip>

> > +XILINX GMIITORGMII Converter Driver Device Tree Bindings
> > +--------------------------------------------------------
> > +
> > +The Gigabit Media Independent Interface (GMII) to Reduced Gigabit
> > +Media Independent Interface (RGMII) core provides the RGMII between
> > +RGMII-compliant Ethernet physical media devices (PHY) and the Gigabit
> Ethernet controller.
> > +This core can be used in all three modes of operation(10/100/1000 Mb/s).
> > +The Management Data Input/Output (MDIO) interface is used to
> > +configure the Speed of operation. This core can switch dynamically
> > +between the three Different speed modes by configuring the conveter
> register through mdio write.
> > +
> > +The MDIO is a bus to which the PHY devices are connected.  For each
> > +device that exists on this bus, a child node should be created.  See
> > +the definition of the PHY node in booting-without-of.txt for an
> > +example of how to define a PHY.
> > +
> > +Required properties:
> > +  - compatible : Should be "xilinx,gmiitorgmii"
> 
> Perhaps xilinx,gmii-to-rgmii.

Sure...

> 
> This needs some sort of version information in the compatible string.

Sure will fix in the next version...

> 
> > +  - reg : The ID number for the phy, usually a small integer
> > +
> > +Example:
> > +	mdio {
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +		ethernet-phy at 0 {
> > +			......
> > +		};
> > +                gmii_to_rgmii: gmii_to_rgmii at 8 {
> 
> Don't use underscores in node names.

Ok will fix in the next version...

Regards,
Kedar.
