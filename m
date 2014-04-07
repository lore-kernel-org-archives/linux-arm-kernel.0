From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 7 Apr 2014 10:46:44 -0600
Subject: [RESEND: RFC PATCH 3/3] pcie: keystone: add pcie driver based on
 designware core driver
In-Reply-To: <5342D47F.4010506@ti.com>
References: <1395707726-20437-1-git-send-email-m-karicheri2@ti.com>
 <1395707726-20437-4-git-send-email-m-karicheri2@ti.com>
 <235376049.yyfljDtinu@wuerfel>
 <20140325165421.GB30641@obsidianresearch.com>
 <5342D47F.4010506@ti.com>
Message-ID: <20140407164644.GB9952@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 12:38:23PM -0400, Murali Karicheri wrote:
> On 3/25/2014 12:54 PM, Jason Gunthorpe wrote:
> >On Tue, Mar 25, 2014 at 08:44:36AM +0100, Arnd Bergmann wrote:
> >
> >>I have no idea how this would work with the standard interrupt-map property,
> >>since the legacy interrupt host is now the same device as the pci host.
> >>
> >>Maybe it's better to move the legacy irqchip handling entirely out of
> >>the driver and use a separate device node for the registers so it can
> >>come with its own #interrupt-cells, and then refer to this irqchip from
> >>the interrupt-map.
> >The other DW PCI-E drivers are being fixed to use interrupt-map, so I
> >think this driver should be fixed before it goes in as well.
> 
> Could you send me a patch reference or branch that I can review to
> better understand changes required in my driver to use the bindings
> you have described below?

Bjorn is now merging it:

[PATCH v2 0/6] PCI irq mapping fixes and cleanups
http://www.spinics.net/lists/linux-pci/msg29589.html

Jason
