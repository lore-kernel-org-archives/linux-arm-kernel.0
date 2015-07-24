From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jul 2015 12:14:05 +0100
Subject: [PATCH v2 01/20] arm64: rwlocks: don't fail trylock purely due
 to contention
In-Reply-To: <1437734531-10698-2-git-send-email-will.deacon@arm.com>
References: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
 <1437734531-10698-2-git-send-email-will.deacon@arm.com>
Message-ID: <20150724111404.GB3550@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 11:41:52AM +0100, Will Deacon wrote:
> STXR can fail for a number of reasons, so don't fail an rwlock trylock
> operation simply because the STXR reported failure.
> 
> I'm not aware of any issues with the current code, but this makes it
> consistent with spin_trylock and also other architectures (e.g. arch/arm).
> 
> Reported-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
