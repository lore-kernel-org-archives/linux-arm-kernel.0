From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 6 Sep 2010 12:39:41 +0530
Subject: [PATCH 0/2] ARM: factorise CPU hotplug code
In-Reply-To: <33A307AF30D7BF4F811B1568FE7A9B181C7DC032@EXDCVYMBSTM006.EQ1STM.local>
References: <1283515266-25374-1-git-send-email-sundar.iyer@stericsson.com>
	<33A307AF30D7BF4F811B1568FE7A9B181C7DC032@EXDCVYMBSTM006.EQ1STM.local>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE7AF5@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sundar,

> -----Original Message-----
> From: Sundar R IYER [mailto:sundar.iyer at stericsson.com]
> Sent: Monday, September 06, 2010 10:13 AM
> To: Will Deacon; Shilimkar, Santosh; Kukjin Kim; Colin Cross
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH 0/2] ARM: factorise CPU hotplug code
> 
> Hi All,
> 
> Any comments on these?
> 
> Regards,
> Sundar
> 
> >-----Original Message-----
> >From: Sundar R IYER
> >Sent: Friday, September 03, 2010 5:31 PM
> >To: linux-arm-kernel at lists.infradead.org
> >Cc: STEricsson_nomadik_linux; Sundar R IYER
> >Subject: [PATCH 0/2] ARM: factorise CPU hotplug code
> >
> >Inspired by Will Deacon's cleanup for the Realview series, this is an
> attempt
> >to factor even more common code and move hotplug functions to the generic
> >arch/arm/common folder
> >
> >Sundar Iyer (2):
> >  ARM: Generalize all CPU Hotplug code across platforms
> >  ux500: Add CPU hotplug support
> >
Generic Approach seems to be good but I think this might complicate few
scenario's regarding how _A_ platform wants to handle the hotplug.

I let other comment on this.
> > arch/arm/common/Makefile           |    1 +
> > arch/arm/common/hotplug.c          |   57
> >++++++++++++++++++++++++++++++++++++
> > arch/arm/include/asm/hotplug.h     |   18 +++++++++++
> > arch/arm/mach-omap2/omap-hotplug.c |   24 +--------------
> > arch/arm/mach-realview/hotplug.c   |   56 ++++--------------------------
> -----
> > arch/arm/mach-s5pv310/hotplug.c    |   56 ++++--------------------------
> -----
> > arch/arm/mach-tegra/hotplug.c      |   56 +++++-------------------------
> -----
> > arch/arm/mach-ux500/Makefile       |    1 +
> > arch/arm/mach-ux500/hotplug.c      |   30 +++++++++++++++++++
> > arch/arm/mach-ux500/platsmp.c      |    4 ++-
> > 10 files changed, 134 insertions(+), 169 deletions(-)
> > create mode 100644 arch/arm/common/hotplug.c
> > create mode 100644 arch/arm/include/asm/hotplug.h
> > create mode 100644 arch/arm/mach-ux500/hotplug.c
> >
> >--
> >1.7.2.dirty
