From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Jan 2015 08:23:34 -0800
Subject: [PATCH v11 3/9] ARM: l2c: Refactor the driver to use commit-like
 interface
In-Reply-To: <1420460348-20302-4-git-send-email-m.szyprowski@samsung.com>
References: <1420460348-20302-1-git-send-email-m.szyprowski@samsung.com>
 <1420460348-20302-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20150105162332.GC4081@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marek Szyprowski <m.szyprowski@samsung.com> [150105 04:22]:
> From: Tomasz Figa <t.figa@samsung.com>
> 
> Certain implementations of secure hypervisors (namely the one found on
> Samsung Exynos-based boards) do not provide access to individual L2C
> registers. This makes the .write_sec()-based interface insufficient and
> provoking ugly hacks.
> 
> This patch is first step to make the driver not rely on availability of
> writes to individual registers. This is achieved by refactoring the
> driver to use a commit-like operation scheme: all register values are
> prepared first and stored in an instance of l2x0_regs struct and then a
> single callback is responsible to flush those values to the hardware.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> [mszyprow: rebased onto 'ARM: l2c: use l2c_write_sec() for restoring
>  latency and filter regs' patch]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

This version seems to boot just fine on am437x here:

Acked-by: Tony Lindgren <tony@atomide.com>
