From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 21 Mar 2014 10:40:15 -0600
Subject: [PATCH v4 6/9] ARM: shmobile: Add PCIe device tree nodes for
 R8A7790
In-Reply-To: <6044873.2S2Xlhp0hC@wuerfel>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
 <532C5ADE.4030708@cogentembedded.com>
 <OF4D80B18E.5A1F55AB-ON80257CA2.0051AADA-80257CA2.0051D412@eu.necel.com>
 <6044873.2S2Xlhp0hC@wuerfel>
Message-ID: <20140321164015.GA3374@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 03:57:25PM +0100, Arnd Bergmann wrote:
> On Friday 21 March 2014 14:53:48 Phil.Edworthy at renesas.com wrote:
> > 
> > > > +      reg = <0 0xfe000000 0 0x80000>;
> > > > +      #address-cells = >;
> > > > +      #size-cells = <2>;
> > > > +      device_type = "pci";
> > > 
> > >     This legacy property is only meaningful for the true OF firmware and 
> > thus 
> > > have been phased out (it's only actively used for the memory nodes).
> > Ok, thanks for pointing this out.
> > 
> 
> I think the code still relies on it for PCI though.

Right, it must be present for PCI nodes, it triggers special behavior
in the address parsing routines.

What Phil has looks correct to me.

Regards,
Jason
