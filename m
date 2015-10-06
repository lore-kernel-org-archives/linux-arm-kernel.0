From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 6 Oct 2015 10:11:30 +0200
Subject: [PATCH] arm: make psci_smp_available() depend on SMP + PSCI as
 the makefile does
In-Reply-To: <1443820404-16431-1-git-send-email-sebastian@breakpoint.cc>
References: <1443820404-16431-1-git-send-email-sebastian@breakpoint.cc>
Message-ID: <20151006081130.GE18633@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2015 at 11:13:24PM +0200, Sebastian Andrzej Siewior wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> with CONFIG_ARM_PSCI=y, CONFIG_SMP=n and CONFIG_ARCH_TEGRA_124_SOC=y I
> end up with:
> 
> |arch/arm/mach-tegra/built-in.o: In function `tegra114_cpuidle_init':
> |arch/arm/mach-tegra/cpuidle-tegra114.c:93: undefined reference to `psci_smp_available'
> |Makefile:927: recipe for target 'vmlinux' failed
> 
> during build testing.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/arm/include/asm/psci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Jan Kiszka sent out an equivalent patch back in May, but it seems like
discussion stalled on that. He resent a few days ago:

	http://patchwork.ozlabs.org/patch/521597/

Let me see if I can get the original discussion resumed. I'll add you in
the loop.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151006/fef61e7b/attachment.sig>
