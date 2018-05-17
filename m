From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 May 2018 18:20:52 +0100
Subject: [PATCH] arm64/sve: Write ZCR_EL1 on context switch only if changed
In-Reply-To: <1526320269-27088-1-git-send-email-Dave.Martin@arm.com>
References: <1526320269-27088-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180517172051.py6idjrwjl7bnzis@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 06:51:09PM +0100, Dave P Martin wrote:
> Writes to ZCR_EL1 are self-synchronising, and so may be expensive
> in typical implementations.
> 
> This patch adopts the approach used for costly system register
> writes elsewhere in the kernel: the system register write is
> suppressed if it would not change the stored value.
> 
> Since the common case will be that of switching between tasks that
> use the same vector length as one another, prediction hit rates on
> the conditional branch should be reasonably good, with lower
> expected amortised cost than the unconditional execution of a
> heavyweight self-synchronising instruction.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Queued for 4.18. Thanks.

-- 
Catalin
