From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 2 May 2011 21:32:46 +0200
Subject: AT91: PMC definitions are plaform-depenent
In-Reply-To: <1304352989.17141.9.camel@redbox>
References: <1304352989.17141.9.camel@redbox>
Message-ID: <20110502193246.GL1212@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:16 Mon 02 May     , Andrew Victor wrote:
> For supporting multiple AT91 processors in a single kernel image, the
> base address of the PMC controller cannot be calculated at compile-time.
> Changes required:
> * calculate PMC base address in processor-dependent code and pass it
> through to the clocks driver at initialization time.
> * arch_idle() need to call into processor-dependent code to put the CPU
> to sleep.  Added an 'at91_arch_idle' callback.
> * Move at91_pm_verify_clocks() from pm.c to clocks.c
> * Rename definitions of AT91_PMC to AT91xxx_PMC.
no need the PMC is at the same address on all soc

with my patch that update the AT91_BASE_SYS to allow the same map io all at91
we do not need have a specific PMC base address

Best Regards,
J.
