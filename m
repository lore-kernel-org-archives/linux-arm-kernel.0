From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 06 Jun 2014 08:48:26 +0200
Subject: [PATCH RFC v1 1/2] documentation/iommu: Add description of
 Hisilicon System MMU binding
In-Reply-To: <1401975430-2648-2-git-send-email-thunder.leizhen@huawei.com>
References: <1401975430-2648-1-git-send-email-thunder.leizhen@huawei.com>
 <1401975430-2648-2-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <8620067.9Lo76DOS52@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 June 2014 21:37:09 Zhen Lei wrote:

> +- smmu-masters  : A list of phandles to device nodes representing bus
> +                  masters for which the SMMU can provide a translation
> +                  and their corresponding StreamIDs (see example below).
> 

We're currently in the process of defining a generic binding for IOMMUs.

While the smmu-masters property was copied from an existing binding,
I think we will end up migrating away from that towards a common way
to express those things, and we shouldn't add another one doing this
in a nonstandard way. Please have a look at the latest discussion
about the iommu binding using #iommu-cells and a reference from the
master to the iommu and see if you can migrate your code to use that.

	Arnd
