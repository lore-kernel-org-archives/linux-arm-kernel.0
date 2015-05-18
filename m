From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 May 2015 14:30:45 +0100
Subject: [PATCH] arm64: Rename temp variable in read*_relaxed()
In-Reply-To: <4f9792c7d10ca30a9b6ba5e2860b56814a41309c.1431947444.git.michal.simek@xilinx.com>
References: <4f9792c7d10ca30a9b6ba5e2860b56814a41309c.1431947444.git.michal.simek@xilinx.com>
Message-ID: <20150518133044.GD21251@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 01:10:48PM +0200, Michal Simek wrote:
> This resolves the following sparse warning from readl() and other
> macros, which ends up embedding readl_relaxed() using the same
> variable.
> 
> Warning log:
> include/asm-generic/io.h:364:16: warning: symbol '__v' shadows an
> earlier one
> include/asm-generic/io.h:364:16: originally declared here
> include/asm-generic/io.h:372:16: warning: symbol '__v' shadows an
> earlier one
> include/asm-generic/io.h:372:16: originally declared here
> include/asm-generic/io.h:380:16: warning: symbol '__v' shadows an
> earlier one
> include/asm-generic/io.h:380:16: originally declared here
> include/asm-generic/io.h:568:16: warning: symbol '__v' shadows an
> earlier one
> include/asm-generic/io.h:568:16: originally declared here
> include/asm-generic/io.h:576:16: warning: symbol '__v' shadows an
> earlier one
> include/asm-generic/io.h:576:16: originally declared here
> include/asm-generic/io.h:584:16: warning: symbol '__v' shadows an
> earlier one
> include/asm-generic/io.h:584:16: originally declared here
> 
> The same patch was already applied to arm32 as
> "ARM: 7118/1: rename temp variable in read*_relaxed()"
> (sha1: b0c1264f534a1cb3c52036a23a04d238434a0df6)
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Applied. Thanks.

-- 
Catalin
