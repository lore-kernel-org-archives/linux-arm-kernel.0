From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 15 Aug 2013 16:22:38 +0100
Subject: [PATCH 1/2] Documentation: devicetree: arm: cpus/cpu nodes
 bindings updates
In-Reply-To: <520CE665.8060907@gmail.com>
References: <1376559743-31848-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1376559743-31848-2-git-send-email-lorenzo.pieralisi@arm.com>
 <520CE665.8060907@gmail.com>
Message-ID: <20130815152238.GF17839@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Andrew, Gregory and Thomas to check the Marvell compatible names]

On Thu, Aug 15, 2013 at 03:32:05PM +0100, Rob Herring wrote:
> On 08/15/2013 04:42 AM, Lorenzo Pieralisi wrote:
> > In order to extend the current cpu nodes bindings to newer CPUs
> > inclusive of AArch64 and to update support for older ARM CPUs this
> > patch updates device tree documentation for the cpu nodes bindings.
> > 
> > Main changes:
> >     - adds 64-bit bindings
> >     - define usage of #address-cells
> >     - defines behaviour on pre and post v7 uniprocessor systems
> >     - adds ARM 11MPcore specific reg property definition
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  Documentation/devicetree/bindings/arm/cpus.txt | 424 ++++++++++++++++++++++---
> >  1 file changed, 377 insertions(+), 47 deletions(-)
> > 
> 
> The binding looks mostly fine to me.
> 
> [snip]
> 
> > +			    "faraday,fa526"
> > +			    "intel,sa110"
> > +			    "intel,sa1100"
> > +			    "marvell,feroceon"
> > +			    "marvell,mohawk"
> > +			    "marvell,pj4"
> > +			    "marvell,sheeva-v7"
> > +			    "marvell,xsc3"
> > +			    "marvell,xscale"
> 
> Better make sure the Marvell folks are happy with these. We don't need
> another rename here. I'm too annoyed with all the renames to pay attention.

Ok, I will verify that, I copied maintainers in.

On a side note I have just noticed that last cycle some dts were merged in the
kernel with cpu nodes that are not compliant (not picking on anyone,
eg am4372.dtsi).
Please prevent this from happening from now onwards, really please.

> > +
> > +Example 4 (ARM Cortex-A57 64-bit system running OS in AArch64):
> > +
> 
> Going back to my comments that the dtb can't be dependent on the OS,
> these 2 examples don't make sense.

Gah, my bad sorry, I missed the examples while removing dependency on the OS
from the bindings.

> > +
> > +Example 5 (ARM Cortex-A57 64-bit system running OS in AArch32):
> 
> This example should be removed.

Yes, consider it done, see above.

Thanks,
Lorenzo
