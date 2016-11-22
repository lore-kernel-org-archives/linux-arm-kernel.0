From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Nov 2016 11:17:52 +0100
Subject: [RFC PATCH 11/11] ARM: Allow ARCH_MULTIPLATFORM to be selected
 for NOMMU
In-Reply-To: <1479806768-39911-12-git-send-email-vladimir.murzin@arm.com>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-12-git-send-email-vladimir.murzin@arm.com>
Message-ID: <16587553.f9R1mxJih5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 22, 2016 9:26:08 AM CET Vladimir Murzin wrote:
> With this patch applied potentially any platform can be built in NOMMU
> configurations if CONFIG_EXPERT is selected. However, there is no
> guaranty that platform can successfully run such Image. So the main
> motivation behind of this patch:
> - bring build coverage for NOMMU configurations
> - allow known working NOMMU platforms (like R-class) to be used
> - pave a way to add support for single address space (aka 1:1 mapping)
>   for MMU platforms, so they can be usable in NOMMU configurations
> 
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>

I'd have to give this a spin with my randconfig build setup, I'd
rather not introduce build regressions. Have you tried an
allmodconfig build with CONFIG_MMU disabled?

Can you provide a git tree that I can try pulling in?

Another question is what architecture levels and what platforms
we want to support without MMU. The only ARMv4/v5 platform we
still have that can actually use NOMMU cores is Integrator
with its ARM7TDMI, ARM920T and ARM966E core tiles (and possibly
others I couldn't immediately find). Do we actually care about
them any more now that all the NOMMU world is ARMv7-M? Are
there any benefits in running an ARM920T or ARM926E core
with MMU disabled, and does this work with your patches?

If not, we could limit it to ARMv7-A/R and possibly ARMv6.
Depending on how the build tests go, a per-platform opt-in
might be easier than having an opt-out for things that
don't work.

	Arnd
