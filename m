From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 13 Apr 2018 10:24:41 +0100
Subject: [PATCH v2 00/13] kernel/locking: qspinlock improvements
In-Reply-To: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
References: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
Message-ID: <20180413092441.cebb54suvjufw6m3@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2018 at 07:01:07PM +0100, Will Deacon wrote:
>   * Spin for a bounded duration while lock is observed in the
>     pending->locked transition

FWIW, I updated my model [1] to include the bounded handover loop and,
as expected, it passes the liveness check (well, assuming fairness of
other operations like fetch_or, cmpxchg etc).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/kernel-tla.git/tree/qspinlock.tla

-- 
Catalin
