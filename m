From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 05 Jul 2010 09:25:19 -0000
Subject: [patch 0/2] [patch 0/2] ARM: Disable outer cache before kexec call -V2
Message-ID: <20100705091706.660272375@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch series addresses the problem, that the kexec code
does not disable the outer cache before disabling the inner cache and
jumping into the new kernel. This results in random crashes of the new
kernel.

Changes since version 1:

 - added flush_all() and inv_all() functions to outer_cache_fns
   so OMAP can override the disable() function easily.

 - changed the implementation from inv_all() -> disable() to
   flush_all() -> disable() -> inv_all() according to feedback from
   Russell and Catalin.

Thanks,

	tglx
