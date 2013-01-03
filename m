From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 3 Jan 2013 12:48:44 +0200
Subject: [PATCH V2 1/2] ARM: tegra: update the cache maintenance order
 for CPU shutdown
In-Reply-To: <1357195380-5494-1-git-send-email-josephl@nvidia.com>
References: <1357195380-5494-1-git-send-email-josephl@nvidia.com>
Message-ID: <20130103104844.GV19766@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 03, 2013 at 07:42:59AM +0100, Joseph Lo wrote:
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
> 

Both patches

Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>
