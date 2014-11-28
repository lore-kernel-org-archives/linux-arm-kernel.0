From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Nov 2014 13:19:28 +0000
Subject: [RFC PATCH v4 0/8] Introduce automatic DMA configuration for
 IOMMU masters
In-Reply-To: <20141128130336.GF3156@suse.de>
References: <1415991397-9618-1-git-send-email-will.deacon@arm.com>
 <546C7D36.7030400@samsung.com> <20141119114150.GD15985@arm.com>
 <54743139.2020804@samsung.com> <20141126174707.GO14866@arm.com>
 <20141128130336.GF3156@suse.de>
Message-ID: <20141128131928.GE7144@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 01:03:36PM +0000, jroedel at suse.de wrote:
> On Wed, Nov 26, 2014 at 05:47:07PM +0000, Will Deacon wrote:
> > Joerg, would you expect this to go via your tree or via something broader
> > like arm-soc, with your Ack on the IOMMU bits (patches 1, 3 and 4) instead?
> 
> Hmm, I don't like the idea of storing private data in iommu_ops. But
> given that this is already an improvement we can build on later, here is
> my
> 
> 	Acked-by: Joerg Roedel <jroedel@suse.de>

Thanks, Joerg! I'll repost this series shortly with the relevant acks.

> To further improve this we should probably introduce a seperate
> iommu-descriptor data-structure later which then describes a single
> hardware iommu device.

Yes, I agree. I'd like to put the pgsize_bitmap in there too, as the page
table series I posted yesterday has to play games to keep the mask
restricted based on the tables in use by any given domain.

Will
