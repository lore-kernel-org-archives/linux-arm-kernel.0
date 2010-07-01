From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 01 Jul 2010 17:14:47 +0100
Subject: [patch 0/2] ARM: Disable outer cache before kexec call
In-Reply-To: <20100701160206.539545857@linutronix.de>
References: <20100701160206.539545857@linutronix.de>
Message-ID: <1278000887.7482.12.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Thu, 2010-07-01 at 17:05 +0100, Thomas Gleixner wrote:
> The following patch series addresses the problem, that the kexec code
> does not disable the outer cache before disabling the inner cache and
> jumping into the new kernel. This results in random crashes of the new
> kernel.

We may need other ways to work around this problem. There are platforms
like OMAP3 (I think) where the L2 cache cannot be disabled as Linux is
running in non-secure (normal) mode.

Cannot some extra cache flushing work around this problem?

-- 
Catalin
