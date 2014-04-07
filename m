From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 07 Apr 2014 09:35:37 -0600
Subject: L2 cache suspend/resume
In-Reply-To: <20140405112700.GJ7528@n2100.arm.linux.org.uk>
References: <20140405112700.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <5342C5C9.8010904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2014 05:27 AM, Russell King - ARM Linux wrote:
> While looking through the L2 resume code paths, I notice that:
> 
>  * exynos
>  * imx
>  * tegra
> 
> all resume their L2 caches from assembly code, rather than using
> outer_disable() before cpu_suspend(), and outer_resume() afterwards.
> From what I can see, these are all running in the secure world, so that
> isn't the reason.
> 
> What is the reason for this difference?  Can these three be converted to
> the outer_disable()...outer_resume() method?

Joseph, Peter, can you please comment on this. Thanks.
