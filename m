From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 26 Nov 2013 15:37:47 +0000
Subject: [PATCH v2] arm64: enable EDAC on arm64
In-Reply-To: <1385154308-31335-1-git-send-email-robherring2@gmail.com>
References: <1385154308-31335-1-git-send-email-robherring2@gmail.com>
Message-ID: <20131126153747.GC692@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 09:05:08PM +0000, Rob Herring wrote:
> +static inline void atomic_scrub(void *va, u32 size)
> +{
> +	unsigned int *virt_addr = va;
> +	unsigned int i;
> +
> +	for (i = 0; i < size / sizeof(*virt_addr); i++, virt_addr++) {

BTW, maybe the compiler is smart enough to drop the i but why not just
use a int *last_addr = va + size - 3; and just compare against this?

-- 
Catalin
