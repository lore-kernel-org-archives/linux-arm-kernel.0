From: lists@kaiser.cx (Martin Kaiser)
Date: Mon, 20 Feb 2017 18:06:32 +0100
Subject: [PATCH 0/4] kuser updates for ARM-only vs Thumb
In-Reply-To: <20170209121756.GC27312@n2100.armlinux.org.uk>
References: <20170209121756.GC27312@n2100.armlinux.org.uk>
Message-ID: <20170220170632.GA6558@botnar.kaiser.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thus wrote Russell King - ARM Linux (linux at armlinux.org.uk):

> A while back, an issue was raised about the return instruction used
> in the kuser page when building an ARMv4 and later environment.

> In order to fix this, I suggested building the kuser code for both
> variants and selecting the appropriate version at run time.  This
> seemed to be a simple solution, but due to the fix-ups and need to
> build the appropriate version for the Kconfig options selected,
> turned out to be not quite as trivial as I hoped.

> Nevertheless, this patch series provides that solution.

> As a side effect of this, the first patch is one which should be
> merged irrespective of the remainder as it provides a useful cleanup
> to the large number of dependencies for the ARM_THUMB option.

Since this was merged (commit bf4b17749f8632696134c8705f294ce02c85c1fa),
linux-next would stop working on my imx258 (ARM926T).

Kernel panic - not syncing: Attempted to kill init!  exitcode=0x00000004

It turned out that CONFIG_ARM_THUMB was not set in my kernel config,
enabling it fixed the problem.

Does this mean the kuser helpers now use thumb instructions and a user
space binary crashes when it uses the helpers and thumb binaries are not
supported?

If CONFIG_CPU_THUMB_CAPABLE requires CONFIG_ARM_THUMB, should we make
this more explicit in the code?

Thanks,
Martin
