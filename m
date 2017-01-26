From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Jan 2017 17:48:17 +0000
Subject: [PATCH 5/5] iommu: Allow default domain type to be set on the
 kernel command line
In-Reply-To: <20170126171555.GD27598@8bytes.org>
References: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
 <1484849955-1871-6-git-send-email-will.deacon@arm.com>
 <20170126171555.GD27598@8bytes.org>
Message-ID: <20170126174816.GO14167@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 06:15:55PM +0100, Joerg Roedel wrote:
> On Thu, Jan 19, 2017 at 06:19:15PM +0000, Will Deacon wrote:
> > Rather than modify each IOMMU driver to provide different semantics for
> > DMA domains, instead we introduce a command line parameter that can be
> > used to change the type of the default domain. Passthrough can then be
> > specified using "iommu.default_domain=identity" on the kernel command
> > line.
> 
> I like the general idea of this, but the above is a terrible name for a
> kernel commandline-parameter. The x86 iommus support iommu=pt which is
> pretty much the same as this patch does.

Happy to bikeshed the name ;)

> How about something like "iommu.passthrough=0/1"? And please add the
> parameter to the kernel documentation too.

Sure, if you think that the identity domain is the only thing we'll ever
want to set (so far, it's the only thing people have asked me for).

Will
