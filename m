From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 4 Jun 2014 23:32:00 +0200
Subject: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <4830064.JvgTAs8Xty@wuerfel>
References: <1400877395-4235-1-git-send-email-thierry.reding@gmail.com>
 <20140530112226.GA3949@e103592.cambridge.arm.com>
 <4830064.JvgTAs8Xty@wuerfel>
Message-ID: <20140604213159.GB18780@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 09:01:19PM +0200, Arnd Bergmann wrote:
> On Friday 30 May 2014 12:22:32 Dave Martin wrote:
> > > +
> > > +Examples:
> > > +=========
> > > +
> > > +Single-master IOMMU:
> > > +--------------------
> > > +
> > > +	iommu {
> > > +		#address-cells = <0>;
> > > +		#size-cells = <0>;
> > > +	};
> > > +
> > > +	master {
> > > +		iommus = <&/iommu>;
> > > +	};
> > > +
> > > +Multiple-master IOMMU with fixed associations:
> > > +----------------------------------------------
> > > +
> > > +	/* multiple-master IOMMU */
> > > +	iommu {
> > > +		/*
> > > +		 * Masters are statically associated with this IOMMU and
> > > +		 * address translation is always enabled.
> > > +		 */
> > > +		#address-cells = <0>;
> > > +		#size-cells = <0>;
> > 
> > In this example, can different translations be set up for the different
> > masters?
> > 
> > With no cells available to contain any sort of ID, it looks like this
> > is not possible.
> 
> Correct, this example is for an IOMMU that does not use IDs but has a
> shared address space for all devices.

Couldn't these device all still have separate address spaces?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140604/bc24c4e6/attachment.sig>
