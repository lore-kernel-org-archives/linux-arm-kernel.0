From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Feb 2014 19:30:25 -0700
Subject: [PATCH v2 0/9] ARM: multi-platform kconfig cleanup and mach-virt
 removal
In-Reply-To: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
Message-ID: <52FC2E41.9050501@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2014 02:11 PM, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> This series removes common kconfig options required by multi-platform
> builds out of individual platforms as they are redundant. Patches 2 and
> 3 make SMP and CACHE_L2X0 config options visible on MULTI_V7 builds as
> most platforms enable these options and all platforms can run with them
> enabled.
> 
> The previous version [1] was mainly a discussion about v6 vs. v6K.
> Several platforms have this wrong and incorrectly select v6 when the
> more optimal v6K option could be used. After more research, my memory
> about i.MX31 was wrong and it does need to remain v6. I've tested the
> v6K change on Rasp Pi. The default change to v6K for MULTI_V6 does not
> switch any platforms. I don't plan to submit the v6K changes for
> platforms without platform maintainers acks or testing. 
> 
> Finally, patch 8 removes mach-virt as it is no longer needed. The core
> ARM code can handle all the necessary initialization and mach-virt is
> left as a kconfig option. Although not really related to this series, 
> it would otherwise conflict with it.

For mach-bcm2835, the series,
Tested-by: Stephen Warren <swarren@wwwdotorg.org>

And patch 5/9 also now,
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
