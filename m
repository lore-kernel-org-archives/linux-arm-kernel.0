From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 1 Apr 2015 17:53:51 +0200
Subject: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
 iommu_ops
In-Reply-To: <20150401115340.GG1552@arm.com>
References: <20150327171946.GL1562@arm.com> <20150331142440.GD22683@8bytes.org>
 <20150331144956.GA24094@arm.com>
 <1427817050.5567.148.camel@redhat.com>
 <20150401115340.GG1552@arm.com>
Message-ID: <20150401155351.GH4441@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Wed, Apr 01, 2015 at 12:53:40PM +0100, Will Deacon wrote:
> Joerg: are you still against merging this? If so, what do you need to
> see in order to change your mind? This is certainly something that we
> need on ARM-based systems and, tbh, the direction that the IOMMU core is
> going seems to be towards a N:1 domain:IOMMU mapping anyway (c.f. your
> series to embed struct iommu_domain in a driver-private data structure).

What I want is consistent behavior between drivers. Until now I tried to
push for the domain concept, which allows to attach arbitrary devices to
a domain. This patch-set makes it impossible to achieve this goal,
that's why I am resistant against it.

We can discuss moving into another direction with the IOMMU-API, and
re-evaluate then if this patch-set is still required.


	Joerg
