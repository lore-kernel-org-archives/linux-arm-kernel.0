From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 9 Mar 2010 16:58:23 +0530
Subject: [PATCH] ARM: Improve the L2 cache performance when PL310 is used
In-Reply-To: <000501cabf78$bceab6c0$36c02440$@tuckley@arm.com>
References: <20100309101248.7359.60873.stgit@e102109-lin.cambridge.arm.com>
	<000401cabf73$79a19fa0$6ce4dee0$@tuckley@arm.com>
	<1268131959.3239.11.camel@e102109-lin.cambridge.arm.com>
	<000501cabf78$bceab6c0$36c02440$@tuckley@arm.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C461AB3B@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Colin Tuckley
> Sent: Tuesday, March 09, 2010 4:38 PM
> To: linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH] ARM: Improve the L2 cache performance when PL310 is used
> 
> > -----Original Message-----
> > From: Catalin Marinas
> 
> > But do they use an L220? Or they don't use anything?
> 
> The A8 has it's own L2 cache design, the chip used on the PBA8 has a bit tacked on that makes it look
> a bit like a 220. I'm also told that it's possible to implement an A8 without a level two cache.
> 
> I think this is a case of reading the docs or maybe raising an Arm-support ticket.
> 
Just as an example,
Both OMAP3 and OMAP4 are based on ARMv7.  OMAP3 there is Cortex-A8 with internal
L2 cache where as OMAP4 is Cortex-A9 with Pl310 as external L2. So below 
approach from Catalin should work at least for v7 based OMAPs for sure.

+config CACHE_PL310
+	bool
+	depends on CACHE_L2X0
+	default y if CPU_V7
+	help
+	  This option enables support for the PL310 cache controller.
+
OMAP3 -- "CACHE_PL310" won't be enabled because "CACHE_L2X0" isn't enabled.
OMAP4 -- PL310 is enabled because "CACHE_L2X0" is enabled

Regards,
Santosh
