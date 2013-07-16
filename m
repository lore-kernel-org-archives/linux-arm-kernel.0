From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Jul 2013 17:20:04 -0600
Subject: [PATCH v2 09/22] amba: Move AHB to core_initcall
In-Reply-To: <1373021097-32420-10-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
 <1373021097-32420-10-git-send-email-hdoyu@nvidia.com>
Message-ID: <51E5D524.1000903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> Move AHB to core_initcall in order to instanciate this device earlier
> than others since IOMMU depends on AHB and then IOMMU driver needs to
> reigster other platform devices as IOMMU'able.

Oh dear, this really is looking like we shouldn't be playing games by
attempting to force the initialization order. An explicit bus structure
and/or having client devices go and attach to the SMMU, would mean we
didn't have to play games like this:-(
