From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Sep 2016 10:49:53 +0100
Subject: [PATCH v2.1] arm64: kgdb: handle read-only text / modules
In-Reply-To: <20160923074208.9899-1-takahiro.akashi@linaro.org>
References: <20160923074208.9899-1-takahiro.akashi@linaro.org>
Message-ID: <20160923094953.GC27704@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 04:42:08PM +0900, AKASHI Takahiro wrote:
> Handle read-only cases (CONFIG_DEBUG_RODATA/CONFIG_DEBUG_SET_MODULE_RONX)
> by using aarch64_insn_write() instead of probe_kernel_write().
> See how this works:
>     commit 2f896d586610 ("arm64: use fixmap for text patching")
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: <stable@vger.kernel.org> # 3.18-3.19: 2f896d5: arm64: use fixmap
> Cc: <stable@vger.kernel.org> # 3.18-3.19: f6242ca: arm64: Fix text
> Cc: <stable@vger.kernel.org> # 4.0-

Queued for 4.8 with a slight change in the last Cc: tag above:

Cc: <stable@vger.kernel.org> # 3.18.x-

Thanks.

-- 
Catalin
