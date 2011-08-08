From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 8 Aug 2011 11:02:34 +0100
Subject: [PATCH] ARM errata: Possible cache data corruption with
	hit-under-miss enabled
In-Reply-To: <1312785148-32531-1-git-send-email-siarhei.siamashka@gmail.com>
References: <1312785148-32531-1-git-send-email-siarhei.siamashka@gmail.com>
Message-ID: <20110808100233.GG29226@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 08, 2011 at 07:32:28AM +0100, Siarhei Siamashka wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> This patch is a workaround for the 364296 ARM1136 r0pX erratum (possible
> cache data corruption with hit-under-miss enabled). It sets the
> undocumented bit 31 in the auxiliary control register and the FI bit in
> the control register, thus disabling hit-under-miss without putting the
> processor into full low interrupt latency mode.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Tested-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>

I haven't pushed this workaround in the past as I wasn't sure there is
production hardware affected. I recall you mentioned Nokia N800, do you
know which CPU revision does this have?

The erratum description states that only r0p2 is affected, though the
patch doesn't test for this revision (needs some improvement).

-- 
Catalin
