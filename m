From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Jul 2012 15:55:58 +0000
Subject: [PATCH 1/8] ARM: support for Moschip MCS814x SoCs
In-Reply-To: <7233708.5ojzueYxjb@flexo>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
 <20120716142941.666d928c@skate> <7233708.5ojzueYxjb@flexo>
Message-ID: <201207161555.58866.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 July 2012, Florian Fainelli wrote:
> > 
> > > +#define IRQ_PCI_INTA            22
> > > +#define IRQ_PCI_INTB            23
> > > +#define IRQ_PCI_INTC            24
> > > +#define IRQ_PCI_INTD            26
> > 
> > And these probably belong to the DT somehow?
> 
> This would need a complete PCI irq mapping representation, so far we have the 
> DT properties, but not the corresponding code to parse them. I would not 
> qualify this as a major blocker.

Your map_irq function looks broken for anything but the PCI cards
you actually tested, so I think it's better to use the common code
for parsing the DT here.

	Arnd
