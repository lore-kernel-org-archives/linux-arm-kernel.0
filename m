From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 10 Nov 2016 17:16:19 +0100
Subject: [RFC v2 8/8] iommu/arm-smmu: implement add_reserved_regions
 callback
In-Reply-To: <b347ddbc-5066-641c-8101-289fb28624a3@arm.com>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
 <1478258646-3117-9-git-send-email-eric.auger@redhat.com>
 <20161110154606.GH2078@8bytes.org>
 <b347ddbc-5066-641c-8101-289fb28624a3@arm.com>
Message-ID: <20161110161619.GK2078@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 04:07:08PM +0000, Robin Murphy wrote:
> On 10/11/16 15:46, Joerg Roedel wrote:
> > On Fri, Nov 04, 2016 at 11:24:06AM +0000, Eric Auger wrote:
> >> +	resource_list_for_each_entry(window, &bridge->windows) {
> >> +		if (resource_type(window->res) != IORESOURCE_MEM &&
> >> +		    resource_type(window->res) != IORESOURCE_IO)
> >> +			continue;
> > 
> > Why do you care about IO resources?
> 
> [since this is essentially code I wrote]
> 
> Because they occupy some area of the PCI address space, therefore I
> assumed that, like memory windows, they would be treated as P2P. Is that
> not the case?

No, not at all. The IO-space is completly seperate from the MEM-space.
They are two different address-spaces, addressing different things. And
the IO-space is also not translated by any IOMMU I am aware of.


	Joerg
