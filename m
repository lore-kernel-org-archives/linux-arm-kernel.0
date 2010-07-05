From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 05 Jul 2010 13:11:10 +0100
Subject: [patch 1/2] arm: Disable outer (L2) cache in kexec
In-Reply-To: <20100705113227.694603399@linutronix.de>
References: <20100705113227.694603399@linutronix.de>
Message-ID: <1278331870.11315.28.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-07-05 at 12:52 +0100, Thomas Gleixner wrote:
> kexec does not disable the outer cache before disabling the inner
> caches in cpu_proc_fin(). So L2 is enabled across the kexec jump. When
> the new kernel enables chaches again, it randomly crashes.
> 
> Disabling L2 before calling cpu_proc_fin() cures the problem.
> 
> Disabling L2 requires the following new functions: flush_all(),
> inv_all() and disable(). Add them to outer_cache_fns and call them
> from the kexec code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
