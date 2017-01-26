From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 26 Jan 2017 18:15:55 +0100
Subject: [PATCH 5/5] iommu: Allow default domain type to be set on the
 kernel command line
In-Reply-To: <1484849955-1871-6-git-send-email-will.deacon@arm.com>
References: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
 <1484849955-1871-6-git-send-email-will.deacon@arm.com>
Message-ID: <20170126171555.GD27598@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 06:19:15PM +0000, Will Deacon wrote:
> Rather than modify each IOMMU driver to provide different semantics for
> DMA domains, instead we introduce a command line parameter that can be
> used to change the type of the default domain. Passthrough can then be
> specified using "iommu.default_domain=identity" on the kernel command
> line.

I like the general idea of this, but the above is a terrible name for a
kernel commandline-parameter. The x86 iommus support iommu=pt which is
pretty much the same as this patch does.

How about something like "iommu.passthrough=0/1"? And please add the
parameter to the kernel documentation too.


	Joerg
