From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jul 2015 16:30:18 +0100
Subject: [PATCH v2 14/20] arm64: cmpxchg: avoid "cc" clobber in ll/sc
 routines
In-Reply-To: <1437734531-10698-15-git-send-email-will.deacon@arm.com>
References: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
 <1437734531-10698-15-git-send-email-will.deacon@arm.com>
Message-ID: <20150724153018.GO3550@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 11:42:05AM +0100, Will Deacon wrote:
> We can perform the cmpxchg comparison using eor and cbnz which avoids
> the "cc" clobber for the ll/sc case and consequently for the LSE case
> where we may have to fall-back on the ll/sc code at runtime.
> 
> Reviewed-by: Steve Capper <steve.capper@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
