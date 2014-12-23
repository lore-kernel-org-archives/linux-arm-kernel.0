From: tony@atomide.com (Tony Lindgren)
Date: Tue, 23 Dec 2014 09:06:13 -0800
Subject: [PATCH v10 2/8] ARM: l2c: Refactor the driver to use commit-like
 interface
In-Reply-To: <1419331716-8972-3-git-send-email-m.szyprowski@samsung.com>
References: <1419331716-8972-1-git-send-email-m.szyprowski@samsung.com>
 <1419331716-8972-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20141223170613.GM23854@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marek Szyprowski <m.szyprowski@samsung.com> [141223 02:51]:
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

The first patch of the series applied things boot with no problem.
But after applying this one I get the following on am437x:

Unhandled fault: imprecise external abort (0xc06) at 0xb6f33884

Probably the same issue Nishanth mentioned.

Regards,

Tony
