From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 May 2014 08:59:12 +0200
Subject: [PATCH] pci: rcar host needs OF
In-Reply-To: <9614403.Lyniq7F3TJ@wuerfel>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <CAMuHMdWBzBneDqyDxK5HU3Bt_5CyRfTM_f_6YGJHokG_v17_sw@mail.gmail.com>
 <9614403.Lyniq7F3TJ@wuerfel>
Message-ID: <13437915.HeCZ0zGaLk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 May 2014 17:21:54 Arnd Bergmann wrote:
> On Thursday 08 May 2014 17:16:32 Geert Uytterhoeven wrote:
> > On Thu, May 8, 2014 at 5:06 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> > >> @@ -27,7 +27,7 @@ config PCI_TEGRA
> > >>
> > >>   config PCI_RCAR_GEN2
> > >>         bool "Renesas R-Car Gen2 Internal PCI controller"
> > >> -       depends on ARCH_SHMOBILE || (ARM && COMPILE_TEST)
> > >> +       depends on ARCH_SHMOBILE || (ARM && OF && COMPILE_TEST)
> > >>         help
> > >>           Say Y here if you want internal PCI support on R-Car Gen2 SoC.
> > >>           There are 3 internal PCI controllers available with a single
> > >>
> > >
> > > This driver /should/ be able to be built for just the platform case
> > > so it sounds like f8f2fe7355fb stopped this but no-one has yet to
> > > notice.
> > 
> > You mean include/linux/of_pci.h should provide a dummy version of
> > of_irq_parse_and_map_pci() returning 0 in case OF=n?
> 
> Good idea, I'll give this patch some testing in the randconfig builder,
> replacing the one above.

The first version was flawed, I submitted a new patch "[PATCH] of/irq:
provide int of_irq_parse_and_map_pci wrapper" now.

	Arnd
