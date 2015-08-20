From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 20 Aug 2015 10:18:05 +0100
Subject: [PATCH 1/2] of/fdt: make memblock maximum physical address arch
 configurable
In-Reply-To: <1439890482-20798-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1439890482-20798-1-git-send-email-ard.biesheuvel@linaro.org>
 <1439890482-20798-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150820091805.GB2972@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 18, 2015 at 11:34:41AM +0200, Ard Biesheuvel wrote:
> When parsing the memory nodes to populate the memblock memory
> table, we check against high and low limits and clip any memory
> that exceeds either one of them.
> 
> However, for arm64, the high limit of (phys_addr_t)~0 is not very
> meaningful, since phys_addr_t is 64 bits (i.e., no limit) but there
> may be other constraints that limit the memory ranges that we can
> support.
> 
> So rename MAX_PHYS_ADDR to MAX_MEMBLOCK_ADDR (for clarity) and only
> define it if the arch does not supply a definition of its own.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
