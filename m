From: thierry.reding@gmail.com (Thierry Reding)
Date: Sat, 17 May 2014 22:48:06 +0200
Subject: [PATCH] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140517170455.08e181f16d3abf36d1ec6274@samsung.com>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
 <20140517170455.08e181f16d3abf36d1ec6274@samsung.com>
Message-ID: <20140517204805.GA1046@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 17, 2014 at 05:04:55PM +0900, Cho KyongHo wrote:
> On Fri, 16 May 2014 14:23:18 +0200, Thierry Reding wrote:
[...]
> > +Examples:
> > +=========
> > +
> > +Single-master IOMMU:
> > +--------------------
> > +
> > +	iommu {
> > +		#iommu-cells = <0>;
> > +	};
> > +
> > +	master {
> > +		iommu = <&/iommu>;
> > +	};
> > +
> 
> Great work, Thierry.
> 
> One simple comment.
> 
> This should be also applicable to multi-master IOMMUs that the masters
> of an IOMMU is not configurable with ID or something.
> I think the title needs to be changed to cover such IOMMUs which always
> translate master's transactions and unable to change the configuration
> of the relationship between the masters and IOMMUs by S/W.

Agreed, how about we add a separate example for that case:

Multiple-master IOMMU with fixed associations:
----------------------------------------------

	/* multiple-master IOMMU */
	iommu {
		/*
		 * Masters are statically associated with this IOMMU and
		 * address translation is always enabled.
		 */
		#iommu-cells = <0>;
	};

	/* static association with IOMMU */
	master at 1 {
		reg = <1>;
		iommus = <&/iommu>;
	};

	/* static association with IOMMU */
	master at 2 {
		reg = <2>;
		iommus = <&/iommu>;
	};

?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140517/c41fa770/attachment.sig>
