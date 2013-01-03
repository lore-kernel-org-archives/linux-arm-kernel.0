From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 03 Jan 2013 10:19:15 -0700
Subject: [PATCH V2 1/2] ARM: tegra: update the cache maintenance order
 for CPU shutdown
In-Reply-To: <1357195380-5494-1-git-send-email-josephl@nvidia.com>
References: <1357195380-5494-1-git-send-email-josephl@nvidia.com>
Message-ID: <50E5BD93.6060302@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/2013 11:42 PM, Joseph Lo wrote:
> Updating the cache maintenance order before CPU shutdown when doing CPU
> hotplug.
> The old order:
> * clean L1 by flush_cache_all
> * exit SMP
> * CPU shutdown
> Adapt to:
> * disable L1 data cache by clear C bit
> * clean L1 by v7_flush_dcache_louis
> * exit SMP
> * CPU shutdown
> 
> For CPU hotplug case, it's no need to do "flush_cache_all". And we should
> disable L1 data cache before clean L1 data cache. Then leaving the SMP
> coherency.

The series, applied to Tegra's for-3.9/soc branch.
