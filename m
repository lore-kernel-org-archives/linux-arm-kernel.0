From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Apr 2013 16:27:19 -0700
Subject: [PATCH v4 0/3] ARM: OMAP2+: Export SoC information to
 userspace using SoC infrastructure
In-Reply-To: <1360842924-32429-1-git-send-email-ruslan.bilovol@ti.com>
References: <1360842924-32429-1-git-send-email-ruslan.bilovol@ti.com>
Message-ID: <20130408232718.GE10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ruslan Bilovol <ruslan.bilovol@ti.com> [130214 03:59]:
> Hi,
> 
> This patch series is an attempt to export some OMAP SoC
> information (like name, revision etc.) to userspace.
> The first patch does some unification of OMAP SoC
> information representation in current sources.
> Second patch adds exactly needed changes using
> exists in Linux kernel SoC infrastructure.

Thanks for your patience with these patches,
applying into omap-for-v3.10/soc.

Tony
 
> -----------------------------------------
> v4:
> - Moved common part of late init into common function  in additional
>   separate patch
> - rebased on top of 'omap-for-v3.9/soc' branch of tmlind/linux-omap tree
> 
> -----------------------------------------
> v3:
> - reduced number of lines changed in the first patch (reusing
>   existent code)
> 
> -----------------------------------------
> v2:
> - changed cpu_* -> soc_* variable names
> - rebased on top of 'omap-for-v3.9/soc' branch of tmlind/linux-omap tree
> 
> 
> Ruslan Bilovol (3):
>   ARM: OMAP2+: Move common part of late init into common function
>   ARM: OMAP2+: SoC name and revision unification
>   ARM: OMAP2+: Export SoC information to userspace
> 
>  arch/arm/mach-omap2/common.h |    8 ++++
>  arch/arm/mach-omap2/id.c     |   95 ++++++++++++++++++++++++++++++++++++++----
>  arch/arm/mach-omap2/io.c     |   34 +++++++--------
>  arch/arm/plat-omap/Kconfig   |    1 +
>  4 files changed, 112 insertions(+), 26 deletions(-)
> 
> -- 
> 1.7.9.5
> 
