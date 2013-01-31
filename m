From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 31 Jan 2013 11:11:48 -0700
Subject: [PATCHv2 for soc 3/4] arm: Add v7_invalidate_l1 to cache-v7.S
In-Reply-To: <1359651943-21752-4-git-send-email-dinguyen@altera.com>
References: <1359651943-21752-1-git-send-email-dinguyen@altera.com>
 <1359651943-21752-4-git-send-email-dinguyen@altera.com>
Message-ID: <510AB3E4.40305@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/2013 10:05 AM, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> mach-socfpga is another platform that needs to use
> v7_invalidate_l1 to bringup additional cores. There was a comment that
> the ideal place for v7_invalidate_l1 should be in arm/mm/cache-v7.S

Tested-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Stephen Warren <swarren@nvidia.com>

(on Tegra30 Cardhu, with this patch applied on top of Tegra's for-next
branch, played audio and did repeated CPU hotplugs)

There will be a minor merge conflict when this patch is merged with the
Tegra tree changes, but it's trivial to resolve; some other code was
removed from this file right next to this function.
