From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 19 Nov 2015 17:59:06 +0000
Subject: [V2 PATCH] arm64: restore bogomips information in /proc/cpuinfo
In-Reply-To: <1447872535-31117-1-git-send-email-yang.shi@linaro.org>
References: <1447872535-31117-1-git-send-email-yang.shi@linaro.org>
Message-ID: <20151119175906.GA10823@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 10:48:55AM -0800, Yang Shi wrote:
> As what Pavel Machek reported [1], some userspace applications depend on
> bogomips showed by /proc/cpuinfo.
> 
> Although there is much less legacy impact on aarch64 than arm, but it does
> break libvirt.
> 
> Basically, this patch reverts commit 326b16db9f69fd0d279be873c6c00f88c0a4aad5
> ("arm64: delay: don't bother reporting bogomips in /proc/cpuinfo"), but with
> some tweak due to context change.
> 
> [1] https://lkml.org/lkml/2015/1/4/132
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> Cc: <stable@vger.kernel.org> #3.12+
> Signed-off-by: Yang Shi <yang.shi@linaro.org>

Patch applied as a fix for stable, basically returning back to the
pre-3.12 behaviour. If there is a need for some more useful information
here, it can be done as an additional patch, though without cc: stable.

Thanks.

-- 
Catalin
