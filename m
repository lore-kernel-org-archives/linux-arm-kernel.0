From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Mar 2014 15:53:59 +0000
Subject: Possible mistake in defining TTBR cache-able attributes for v7-2
 level ?
In-Reply-To: <CAPub149amJ0Aa7Y8DLkHbkQzcKFfr--d8oiuFsw7MMokAia4xw@mail.gmail.com>
References: <CAPub149amJ0Aa7Y8DLkHbkQzcKFfr--d8oiuFsw7MMokAia4xw@mail.gmail.com>
Message-ID: <20140314155359.GH18126@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 01:46:27PM +0000, Shiraz Hashim wrote:
> TTB_IRGN_WBWA macro defined in arch/arm/mm/proc-v7-2level.S, seems incorrect
> 
> #define TTB_IRGN_WBWA ? ((0 << 0) | (1 << 6))
> 
> Its intention seems to program as write back and write allocate whereas it
> actually
> programs it? write-through,
> 
> From ARM TRM
> 
> The possible values of IRGN[1:0] are:
> ? 0b00 Normal memory, Inner Non-cacheable.
> ? 0b01 Normal memory, Inner Write-Back Write-Allocate Cacheable.
> ? 0b10 Normal memory, Inner Write-Through Cacheable.
> ? 0b11 Normal memory, Inner Write-Back no Write-Allocate Cacheable.
> 
> --IRGN[0] is b'0 and IRGN[1] is b'6

In the ARMv7 ARM, IRGN[0] is bit 6 and IRGN[1] is bit 0. Which TRM is
this?

-- 
Catalin
