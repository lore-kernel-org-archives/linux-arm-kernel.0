From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 20 Jan 2012 15:15:23 +0800
Subject: [PATCH] ARM: proc-v7.S: remove HARVARD_CACHE preprocessor guards
In-Reply-To: <1326990666-10159-1-git-send-email-will.deacon@arm.com>
References: <1326990666-10159-1-git-send-email-will.deacon@arm.com>
Message-ID: <20120120071520.GB26277@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2012 at 04:31:06PM +0000, Will Deacon wrote:
> On v7, we use the same cache maintenance instructions for data lines
> as for unified lines. This was not the case for v6, where HARVARD_CACHE
> was defined to indicate the L1 cache topology.
> 
> This patch removes the erroneous compile-time check for HARVARD_CACHE in
> proc-v7.S, ensuring that we perform I-side invalidation at boot.
> 
> Reported-by: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Catalin Marinas <Catalin.Marinas@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
