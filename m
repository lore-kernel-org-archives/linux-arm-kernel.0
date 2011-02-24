From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 24 Feb 2011 02:06:05 -0700 (MST)
Subject: [PATCH 7/8] OMAP2+: hwmod: add ability to late-init individual
	hwmods
In-Reply-To: <20110223191212.GA15225@atomide.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
	<20110223071152.5874.54222.stgit@twilight.localdomain>
	<20110223191212.GA15225@atomide.com>
Message-ID: <alpine.DEB.2.00.1102240204190.6198@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Feb 2011, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [110222 23:11]:
> > --- a/arch/arm/mach-omap2/omap_hwmod.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod.c
> > +int __init omap_hwmod_late_init_one(const char *oh_name)
> 
> How about the following naming changes to avoid confusion:
> 
> omap_hwmod_init			-> omap_hwmod_register
> omap_hwmod_late_init		-> omap_hwmod_init
> omap_hwmod_late_init_one	-> omap_hwmod_init_one
> 
> This is because "late_init" gets actually called very early
> during the boot.

Sounds good to me.  Will write a patch to make this change,

- Paul
