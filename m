From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 12 Nov 2014 15:47:16 +0100
Subject: [PATCH v6 05/12] memory: Add NVIDIA Tegra memory controller
 support
In-Reply-To: <20141112142150.GV10744@8bytes.org>
References: <1415376063-17205-1-git-send-email-thierry.reding@gmail.com>
 <1415376063-17205-6-git-send-email-thierry.reding@gmail.com>
 <20141112142150.GV10744@8bytes.org>
Message-ID: <20141112144715.GD26488@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 03:21:50PM +0100, Joerg Roedel wrote:
> On Fri, Nov 07, 2014 at 05:00:56PM +0100, Thierry Reding wrote:
> >  drivers/iommu/tegra-smmu.c               | 1295 ------------------------------
> >  drivers/memory/tegra/smmu.c              |  716 +++++++++++++++++
> 
> This new smmu.c is an IOMMU driver, why do you put it in drivers/memory
> and not in drivers/iommu?

The SMMU is part of a larger IP block that's also a memory controller.
Having it in drivers/iommu would mean that we need to provide a
mechanism to synchronize between the two drivers. They also share a
number of data tables, so that would need to be shared somehow as well.
By keeping both in the same directory we don't have to expose any of
this publicly.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141112/9b541f1f/attachment.sig>
