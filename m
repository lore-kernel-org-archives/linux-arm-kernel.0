From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 7 Aug 2014 08:24:11 +0200
Subject: [PATCH v4 1/1] iommu-api: Add map_sg/unmap_sg functions
In-Reply-To: <53E2BA2D.1050007@codeaurora.org>
References: <1406854484-3848-1-git-send-email-ohaugan@codeaurora.org>
 <1406854484-3848-2-git-send-email-ohaugan@codeaurora.org>
 <20140805151323.GB19709@laptop.dumpdata.com>
 <53E26127.1040805@codeaurora.org>
 <20140806201740.GW9809@8bytes.org>
 <53E2BA2D.1050007@codeaurora.org>
Message-ID: <20140807062410.GC17340@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 06, 2014 at 04:28:45PM -0700, Olav Haugan wrote:
> On 8/6/2014 1:17 PM, Joerg Roedel wrote:
> > On Wed, Aug 06, 2014 at 10:08:55AM -0700, Olav Haugan wrote:
> >> so you are suggesting that I check in "bus_set_iommu()" whether the
> >> driver has set the map_sg/unmap_sg function pointers or not and if not
> >> set it to the default? Is bus_set_iommu() the only way drivers can set
> >> up the callbacks?
> > 
> > This doesn't work as the iommu_ops are now const. You have to either
> > update the iommu drivers individually to point to the default function,
> > or you do the check in the API function itself and fall back to the
> > default it no call-back is provided.
> > 
> 
> Ok, then I think it is better to just leave the fallback where it is now
> in the function itself.

What Konrad was suggesting is what I also proposed. The idea is to
implement a fallback as standalone function, then make all drivers use
that by default in the struct iommu_ops that they register. When drivers
implement an optimized version they can simply replace the fallback
implementation with their own.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140807/b1e51e16/attachment.sig>
