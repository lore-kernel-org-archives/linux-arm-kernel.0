From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 15 Oct 2014 11:10:44 +0200
Subject: [PATCH 2/2] iommu: Implement a dummy bus_set_iommu()
In-Reply-To: <20140818165750.GE9809@8bytes.org>
References: <1406897113-20099-1-git-send-email-thierry.reding@gmail.com>
 <1406897113-20099-2-git-send-email-thierry.reding@gmail.com>
 <20140818165750.GE9809@8bytes.org>
Message-ID: <20141015091043.GA13162@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 06:57:50PM +0200, Joerg Roedel wrote:
> On Fri, Aug 01, 2014 at 02:45:13PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > This allows IOMMU drivers to compile even if IOMMU_API is not selected
> > and helps improve compile coverage.
> 
> IOMMU drivers usually implement the IOMMU-API, so they have a strong
> dependency to it. Why do you want to compile-test an iommu driver
> without testing the iommu core-code as well?

It seems like I never got back to you on this. The reason here is that
for Tegra the IOMMU is part of a larger IP block. The IP block is
primarily a memory controller with a bunch of configuration knobs for
arbitration, prioritization and whatnot. A smaller part of the device
does the IOMMU translation. Therefore the IOMMU implementation would
be part of a larger driver, and having this dummy would reduce the
amount of #ifdefs required.

bus_set_iommu() is also the only function in include/linux/iommu.h that
doesn't have a dummy, so it seemed like a natural thing to do.

That said, I can work around this being absent for !IOMMU_API.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141015/cc11222d/attachment.sig>
