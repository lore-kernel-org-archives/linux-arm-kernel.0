From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 6 Dec 2011 12:11:31 +0000
Subject: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
In-Reply-To: <20111206112545.GQ14542@n2100.arm.linux.org.uk>
References: <1322867573.11728.22.camel@pasglop>
 <20111205161157.GA27550@localhost.localdomain>
 <alpine.LFD.2.02.1112051236350.2357@xanadu.home>
 <20111205180253.GB29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051310150.2357@xanadu.home>
 <20111205192605.GD29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051443190.2357@xanadu.home>
 <20111206093709.GB2274@linaro.org>
 <20111206104654.GN14542@n2100.arm.linux.org.uk>
 <20111206110554.53bddd14@lxorguk.ukuu.org.uk>
 <20111206112545.GQ14542@n2100.arm.linux.org.uk>
Message-ID: <20111206121131.3446266c@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> However, I have suggested in the past that new platforms _should_ avoid
> not just IRQ0 but IRQ0-15 (for a completely different reason to that of
> 'IRQ0 means no IRQ'.)  But such comments just get ignored, so I just
> don't see the point in doing anything about this.  If people experience
> breakage, so be it.  I too will have little sympathy but not for the same
> reason.

The one I can think of that is capable of taking EISA/ISA cards but has
differently IRQ plumbing arrangements is PA-RISC, and they do exactly
this.

Beyond that it probably doesn't come up except in the weird world of PCI
legacy compatibility for legacy IDE and VGA vertical interrupt routing.
In those cases we fix up the PCI config space so the platform in turn can
do proper IRQ plumbing.

Alan
