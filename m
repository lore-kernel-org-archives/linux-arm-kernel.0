From: horms@verge.net.au (Simon Horman)
Date: Mon, 25 Feb 2013 10:43:54 +0900
Subject: [PATCH/RFC 0/4] CPUFreq for kzm9g
In-Reply-To: <1361553474-27022-1-git-send-email-g.liakhovetski@gmx.de>
References: <1361553474-27022-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <20130225014354.GG17964@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 22, 2013 at 06:17:50PM +0100, Guennadi Liakhovetski wrote:
> The first of these patches is a bug-fix, whereas the latter three patches
> are experimental and might want to be discussed. This patch set is based
> on an earlier Simon's topic/all+next branch snapshot.

Could you let me know the commit id of the working branch?

> Attempts to use
> todays checkout failed - I couldn't even boot.

Thanks, I thought that I had tested that but clearly I was mistaken.

The problem appears to be caused by "ARM: shmobile: kzm9g: Populate
platform devices from device tree" which is present in topic/pinmux.

I will remove that branch from topic/all+next until the problem is resolved.
I have also removed the topic/eth_sh and topic/intc-of branches from
topic/all+next as they depend on topic/pinmux.

> Obviously, I'm also using 
> my AS3711 patches and a number of other (not directly related) patches, 
> that I'll be posting separately.

It is not obvious to me why you are using other patches.

> Guennadi Liakhovetski (4):
>   ARM: shmobile: sh73a0: fix Z and ZG clock hierarchy
>   ARM: shmobile: sh73a0: add support for adjusting CPU frequency
>   ARM: shmobile: sh73a0: run sh73a0_clock_init() only once
>   ARM: shmobile: kzm9g-reference: add CPUFreq support
> 
>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   19 ++-
>  arch/arm/mach-shmobile/Kconfig               |    2 +
>  arch/arm/mach-shmobile/clock-sh73a0.c        |  224 +++++++++++++++++++++++++-
>  3 files changed, 236 insertions(+), 9 deletions(-)
