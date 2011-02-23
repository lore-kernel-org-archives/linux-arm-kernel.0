From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Feb 2011 11:12:12 -0800
Subject: [PATCH 7/8] OMAP2+: hwmod: add ability to late-init individual
	hwmods
In-Reply-To: <20110223071152.5874.54222.stgit@twilight.localdomain>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
	<20110223071152.5874.54222.stgit@twilight.localdomain>
Message-ID: <20110223191212.GA15225@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Paul Walmsley <paul@pwsan.com> [110222 23:11]:
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> +int __init omap_hwmod_late_init_one(const char *oh_name)

How about the following naming changes to avoid confusion:

omap_hwmod_init			-> omap_hwmod_register
omap_hwmod_late_init		-> omap_hwmod_init
omap_hwmod_late_init_one	-> omap_hwmod_init_one

This is because "late_init" gets actually called very early
during the boot.

Regards,

Tony
