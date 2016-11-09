From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 9 Nov 2016 17:16:24 +0000
Subject: [PATCH] arm64: percpu: kill off final ACCESS_ONCE() uses
In-Reply-To: <1478283426-6649-1-git-send-email-mark.rutland@arm.com>
References: <1478283426-6649-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20161109171623.GC15943@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 06:17:06PM +0000, Mark Rutland wrote:
> For several reasons it is preferable to use {READ,WRITE}_ONCE() rather than
> ACCESS_ONCE(). For example, these handle aggregate types, result in shorter
> source code, and better document the intended access (which may be useful for
> instrumentation features such as the upcoming KTSAN).
> 
> Over a number of patches, most uses of ACCESS_ONCE() in arch/arm64 have been
> migrated to {READ,WRITE}_ONCE(). For consistency, and the above reasons, this
> patch migrates the final remaining uses.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Will Deacon <will.deacon@arm.com>

I'll queue this for 4.10. Thanks.

-- 
Catalin
