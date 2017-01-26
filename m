From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 26 Jan 2017 17:26:32 +0000
Subject: [PATCH 5/5] iommu: Allow default domain type to be set on the
 kernel command line
In-Reply-To: <20170126171555.GD27598@8bytes.org>
References: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
 <1484849955-1871-6-git-send-email-will.deacon@arm.com>
 <20170126171555.GD27598@8bytes.org>
Message-ID: <5717f26c-44ee-2057-e7dc-8dca42e3cd88@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/01/17 17:15, Joerg Roedel wrote:
> On Thu, Jan 19, 2017 at 06:19:15PM +0000, Will Deacon wrote:
>> Rather than modify each IOMMU driver to provide different semantics for
>> DMA domains, instead we introduce a command line parameter that can be
>> used to change the type of the default domain. Passthrough can then be
>> specified using "iommu.default_domain=identity" on the kernel command
>> line.
> 
> I like the general idea of this, but the above is a terrible name for a
> kernel commandline-parameter. The x86 iommus support iommu=pt which is
> pretty much the same as this patch does.

Indeed, I was keen on making "iommu=pt" also do this default domain
switch itself so we wouldn't need a new option - it didn't *appear* that
that would break the AMD driver (as the only other default domain user
supporting identity domains) but I may have overlooked something.

Robin.

> How about something like "iommu.passthrough=0/1"? And please add the
> parameter to the kernel documentation too.
> 
> 
> 	Joerg
> 
