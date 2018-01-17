From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 17 Jan 2018 13:20:14 +0100
Subject: [PATCH 1/3] arm64: perf: Make PMU interrupt NMI safe
In-Reply-To: <1516190685-20048-2-git-send-email-julien.thierry@arm.com>
References: <1516190685-20048-1-git-send-email-julien.thierry@arm.com>
 <1516190685-20048-2-git-send-email-julien.thierry@arm.com>
Message-ID: <20180117122014.GM2228@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 12:04:43PM +0000, Julien Thierry wrote:
> Before using an NMI, we must make sure the IRQ handler uses no locks and
> only calls NMI safe functions.
> 
> Get rid of PMU lock, saving and restoring the PMU counter selector in the
> PMU interrupt handler

You fail to explain why its safe to do so. Presumably that lock was
there for a reason, why can you remove it and expect things to keep
working?
