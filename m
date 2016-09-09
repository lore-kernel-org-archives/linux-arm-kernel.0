From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 9 Sep 2016 12:34:11 +0100
Subject: [PATCH] arm64: spinlocks: implement smp_mb__before_spinlock() as
 smp_mb()
In-Reply-To: <1473072965-7272-1-git-send-email-will.deacon@arm.com>
References: <1473072965-7272-1-git-send-email-will.deacon@arm.com>
Message-ID: <20160909113411.GB19083@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 11:56:05AM +0100, Will Deacon wrote:
> smp_mb__before_spinlock() is intended to upgrade a spin_lock() operation
> to a full barrier, such that prior stores are ordered with respect to
> loads and stores occuring inside the critical section.
> 
> Unfortunately, the core code defines the barrier as smp_wmb(), which
> is insufficient to provide the required ordering guarantees when used in
> conjunction with our load-acquire-based spinlock implementation.
> 
> This patch overrides the arm64 definition of smp_mb__before_spinlock()
> to map to a full smp_mb().
> 
> Cc: <stable@vger.kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Reported-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Queued for -rc6. Thanks.

-- 
Catalin
