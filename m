From: rric@kernel.org (Robert Richter)
Date: Mon, 26 Jun 2017 19:45:01 +0200
Subject: [Devel] [PATCH v4 2/2] acpi, gicv3-its, numa: Adding numa node
 mapping for gic-its units
In-Reply-To: <76d94864-d121-1d7a-bc23-00ac57cd7fb2@arm.com>
References: <1498111812-17053-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <1498111812-17053-3-git-send-email-ganapatrao.kulkarni@cavium.com>
 <2d99c999-8ded-ac3d-57a2-fd81dbadadea@arm.com>
 <20170626173810.GW658@rric.localdomain>
 <76d94864-d121-1d7a-bc23-00ac57cd7fb2@arm.com>
Message-ID: <20170626174501.GB10237@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.06.17 18:43:47, Marc Zyngier wrote:
> On 26/06/17 18:38, Robert Richter wrote:
> > On 22.06.17 15:49:25, Marc Zyngier wrote:
> >> On 22/06/17 07:10, Ganapatrao Kulkarni wrote:
> >>> Add code to parse SRAT ITS Affinity sub table as defined in ACPI 6.2.
> >>> Later in per device probe, ITS devices are mapped to numa node using
> >>> ITS Id to proximity domain mapping.
> >>>
> >>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> >>> ---
> >>>  drivers/irqchip/irq-gic-v3-its.c | 75 +++++++++++++++++++++++++++++++++++++++-
> >>>  1 file changed, 74 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> >>> index 45ea1933..1c21e01 100644
> >>> --- a/drivers/irqchip/irq-gic-v3-its.c
> >>> +++ b/drivers/irqchip/irq-gic-v3-its.c
> >>> @@ -1833,6 +1833,77 @@ static int __init its_of_probe(struct device_node *node)
> >>>  
> >>>  #define ACPI_GICV3_ITS_MEM_SIZE (SZ_128K)
> >>>  
> >>> +#ifdef CONFIG_ACPI_NUMA
> >>
> >> So given that there is a dependency issue between the irqchip and apcica
> >> trees, I plan on taking this patch with the following change:
> >>
> >> #if defined(CONFIG_ACPI_NUMA) && (ACPI_CA_VERSION >= 0x20170531)
> > 
> > The struct name was changed :/
> > 
> >  s/acpi_srat_its_affinity/acpi_srat_gic_its_affinity/
> > 
> > You need to update this too.
> 
> I changed it when I applied the patch. See
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/irqchip-4.13&id=dbd2b826723319eb6e4bee5214f8901e336c06be
> 
> Which is also in tip/irq/core.

Great, thanks for the pointer.

-Robert
