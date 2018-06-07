From: will.deacon@arm.com (Will Deacon)
Date: Thu, 7 Jun 2018 11:01:40 +0100
Subject: [PATCH V6] arm64: alternative:flush cache with unpatched code
In-Reply-To: <1528327743-29263-1-git-send-email-rokhanna@nvidia.com>
References: <1528327743-29263-1-git-send-email-rokhanna@nvidia.com>
Message-ID: <20180607100140.GG9938@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 06, 2018 at 04:29:03PM -0700, Rohit Khanna wrote:
> In the current implementation,  __apply_alternatives patches
> flush_icache_range and then executes it without invalidating the icache.
> Thus, icache can contain some of the old instructions for
> flush_icache_range. This can cause unpredictable behavior as during
> execution we can get a mix of old and new instructions for
> flush_icache_range.
> 
> This patch modifies __apply_alternatives so that it uses non hot-patched
> __flush_icache_all after applying all the alternatives.

Please can you try the diff I posted the other day? [1]

Will

--->8

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/582861.html
