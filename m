From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Jul 2013 22:32:15 +0100
Subject: [PATCH V3] ARM: add missing linker section markup to head-common.S
In-Reply-To: <1373047855-24145-1-git-send-email-swarren@wwwdotorg.org>
References: <1373047855-24145-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130705213214.GK24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 05, 2013 at 12:10:55PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Macro __INIT is used to place various code in head-common.S into the init
> section. This should be matched by a closing __FINIT. Also, add an
> explicit ".text" to ensure subsequent code is placed into the correct
> section; __FINIT is simply a closing marker to match __INIT and doesn't
> guarantee to revert to .text.
> 
> This historically caused no problem, because macro __CPUINIT was used at
> the exact location where __FINIT was missing, which then placed following
> code into the cpuinit section. However, with commit 22f0a2736 "init.h:
> remove __cpuinit sections from the kernel" applied, __CPUINIT becomes a
> no-op, thus leaving all this code in the init section, rather than the
> regular text section. This caused issues such as secondary CPU boot
> failures or crashes.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> Acked-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> v3: Added .text after __FINIT to force the correct section.
> v2: Moved __FINIT after lookup_processor_type, to correctly match the
> location of __CPUINIT.

Much better, thanks.  Please put it in the patch system and I'll send it
along, thanks.
