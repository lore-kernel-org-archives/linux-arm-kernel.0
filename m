From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 15 May 2014 16:22:08 +0200
Subject: [PATCHv3 3/3] ARM: mvebu: implement L2/PCIe deadlock workaround
In-Reply-To: <6600397.74rV2Hm7nM@wuerfel>
References: <1400145519-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400145519-28530-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <6600397.74rV2Hm7nM@wuerfel>
Message-ID: <20140515162208.30d5687c@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Thu, 15 May 2014 15:26:29 +0200, Arnd Bergmann wrote:

> > +
> > +       if (of_machine_is_compatible("marvell,armada375") ||
> > +           of_machine_is_compatible("marvell,armada38x")) {
> > +               arch_ioremap_caller = armada_pcie_wa_ioremap_caller;
> > +               pci_ioremap_set_mem_type(MT_UNCACHED);
> > +               mvebu_l2x0_pl310_coherent();
> > +       }
> > +
> >         l2x0_of_init(0, ~0UL);
> 
> 
> I wonder whether this should just be move to the existing
> armada_375_380_coherency_init() function to avoid the
> of_machine_is_compatible() check. Other than that,

Indeed, makes a lot of sense to have this in coherency.c instead. Will
be part of v4.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
