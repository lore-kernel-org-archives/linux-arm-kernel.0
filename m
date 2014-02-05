From: will.deacon@arm.com (Will Deacon)
Date: Wed, 5 Feb 2014 10:13:26 +0000
Subject: [PATCH] arm64: add DSB after icache flush in __flush_icache_all()
In-Reply-To: <1391592876-18627-1-git-send-email-vkale@apm.com>
References: <1391592876-18627-1-git-send-email-vkale@apm.com>
Message-ID: <20140205101326.GC28623@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 09:34:36AM +0000, Vinayak Kale wrote:
> Add DSB after icache flush to complete the cache maintenance operation.
> The function __flush_icache_all() is used only for user space mappings
> and an ISB is not required because of an exception return before executing
> user instructions. An exception return would behave like an ISB.
> 
> Signed-off-by: Vinayak Kale <vkale@apm.com>
> ---
>  arch/arm64/include/asm/cacheflush.h |    1 +
>  1 file changed, 1 insertion(+)

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
