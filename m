From: bhupesh.sharma@freescale.com (Sharma Bhupesh)
Date: Thu, 15 Oct 2015 20:11:06 +0000
Subject: [PATCH v3 05/12] doc/bindings: Update Layerscape PCIe devicetree
 binding to be more flexible
In-Reply-To: <5383901.aC2HYopUNW@wuerfel>
References: <1444891672-32117-1-git-send-email-bhupesh.sharma@freescale.com>
 <1444891672-32117-6-git-send-email-bhupesh.sharma@freescale.com>
 <5383901.aC2HYopUNW@wuerfel>
Message-ID: <BY1PR0301MB13039481CB958A3323FB03B2823E0@BY1PR0301MB1303.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Thursday, October 15, 2015 7:47 PM
> 
> On Thursday 15 October 2015 12:17:45 Bhupesh Sharma wrote:
> >
> > +Note that since this controller derives its clocks from the Reset
> > +Configuration Word (RCW) which is used to describe the PLL settings
> > +at the time of chip-reset, the 'clocks' and 'clock-names' properties
> > +from 'designware-pcie.txt' are optional for this controller.
> 
> If this is an option for the dw-pcie block, should this description be
> added to the generic binding instead?

I think this can be moved to the generic bindings for DWC3 PCIe driver. However
I cannot vouch if the same is true for usage of this IP in other SoCs and it
will not break existing drivers if this property is not defined in their SoC DTSI.

So adding a few old ST colleagues (Pratyush, Gabriel, Fabrice), who I am sure have used this IP in ST SoCs
for their comments as well.

So the question would be - do you think it will be ok to make the clock related
properties optional in 'designware-pcie.txt' rather than required.

> 
> > +Also as per the available Reference Manuals, there is no specific
> 'version'
> > +register available in the Freescale PCIe controller register set,
> > +which can allow determining the underlying Designware PCIe controller
> > +version information.
> > +
> >  Required properties:
> > -- compatible: should contain the platform identifier such as
> "fsl,ls1021a-pcie"
> > +- compatible: should contain the platform identifier such as
> > +"fsl,<soc-name>-pcie",
> > +  "snps,dw-pcie".
> 
> You should document all the strings that will be needed here, otherwise a
> driver write does not know what to look for.
> 
> If two chips have a 100% identical PCIe implementation, just use the
> string of the older chip for both.

The chips are not 100% identical and there is no version information register
available for differentiation. So, does the following seem better:

+- compatible: should contain the platform identifier such as
+"fsl,<soc-name>-pcie",
+  "snps,dw-pcie".
+
+ where <soc-name> for e.g. can be ls2080a or ls1021a.

Regards,
Bhupesh
