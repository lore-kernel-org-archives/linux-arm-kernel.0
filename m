From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Nov 2018 15:56:04 -0600
Subject: [PATCH v4 0/6] arm64: Get rid of __early_init_dt_declare_initrd()
In-Reply-To: <20181113002216.GA26854@bogus>
References: <20181105225431.24485-1-f.fainelli@gmail.com>
 <20181106140642.GA19280@rapoport-lnx>
 <68b32163-85ff-45f7-8887-60273da7c6e2@gmail.com>
 <20181113002216.GA26854@bogus>
Message-ID: <20181126215604.GA12509@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2018 at 06:22:16PM -0600, Rob Herring wrote:
> On Mon, Nov 12, 2018 at 12:32:50PM -0800, Florian Fainelli wrote:
> > On 11/6/18 6:06 AM, Mike Rapoport wrote:
> > > On Mon, Nov 05, 2018 at 02:54:25PM -0800, Florian Fainelli wrote:
> > >> Hi all,
> > >>
> > >> Changes in v4:
> > >>
> > >> - dropped initrd_below_start_ok assignment in ARM64, not necessary at
> > >>   all (Ard)
> > >> - replace #ifdef CONFIG_BLK_DEV_INITRD with if
> > >>   (IS_ENABLED(CONFIG_BLK_DEV_INITRD) for consistency with other parts
> > >>   of arm64_memblock_init() (Rob)
> > >>
> > >> Changes in v3:
> > >>
> > >> - use C conditionals in drivers/of/fdt.c
> > >> - added check on phys_initrd_size in arch/arm64/mm/init.c to determine
> > >>   whether initrd_start must be populated
> > >> - fixed a build warning with ARC that was just missing an (unsigned
> > >>   long) cast
> > >>
> > >> Changes in v2:
> > >>
> > >> - get rid of ARCH_HAS_PHYS_INITRD and instead define
> > >>   phys_initrd_start/phys_initrd_size in init/do_mounts_initrd.c
> > >>
> > >> - make __early_init_dt_declare_initrd() account for ARM64 specific
> > >>   behavior with __va() when having CONFIG_DEBUG_VM enabled
> > >>
> > >> - consolidate early_initrd() command line parsing into
> > >>   init/do_mounts_initrd.c
> > >>
> > >> Because phys_initrd_start/phys_initrd_size are now compiled in
> > >> ini/do_mounts_initrd.c which is only built with CONFIG_BLK_DEV_INITRD=y,
> > >> we need to be a bit careful about the uses throughout architecture
> > >> specific code.
> > >>
> > >> Previous discussions/submissions list here:
> > >>
> > >> v3:
> > >> https://www.spinics.net/lists/arm-kernel/msg683566.html
> > >> v2:
> > >> https://lkml.org/lkml/2018/10/25/4
> > >>
> > >> Florian Fainelli (6):
> > >>   nds32: Remove phys_initrd_start and phys_initrd_size
> > >>   arch: Make phys_initrd_start and phys_initrd_size global variables
> > >>   of/fdt: Populate phys_initrd_start/phys_initrd_size from FDT
> > >>   arm64: Utilize phys_initrd_start/phys_initrd_size
> > >>   of/fdt: Remove custom __early_init_dt_declare_initrd() implementation
> > >>   arch: Move initrd= parsing into do_mounts_initrd.c
> > > 
> > > For the series:
> > > 
> > > Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Thanks Mike, Rob, do you want to merge that series through the OF tree?
> 
> Sure, some arch maintainer acks would be nice.

I've now applied the series.

Thanks,

Rob
