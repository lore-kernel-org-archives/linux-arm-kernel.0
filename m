From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Jul 2013 17:18:29 -0600
Subject: [PATCH v2 06/22] ARM: dt: tegra114: iommu: Fix IOMMU register
 address
In-Reply-To: <1373021097-32420-7-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
 <1373021097-32420-7-git-send-email-hdoyu@nvidia.com>
Message-ID: <51E5D4C5.4090109@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> Fix IOMMU register address.

Oh dear, how serious is this?

That incorrect node got added in v3.9 - a long time ago. Does the SMMU
driver touch registers during probe() or under any other condition right
now? If so, can that hang the CPU or end up trashing some other HW
module's registers?

I'm trying to determine whether we need to urgently send this patch as a
fix Cc: stable.
