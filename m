From: vidyas@nvidia.com (Vidya Sagar)
Date: Fri, 6 Jun 2014 11:00:32 +0530
Subject: [PATCH v2] ARM: fix debug prints relevant to PCI devices
In-Reply-To: <1402028592.3038.4.camel@joe-AO725>
References: <1401994068-820-1-git-send-email-vidyas@nvidia.com>
 <1402028592.3038.4.camel@joe-AO725>
Message-ID: <113ACA888B71994BB56E5CF3704953486D6CE1E2DF@BGMAIL02.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

oops... I missed it somehow. I'll post a new patch.

> -----Original Message-----
> From: Joe Perches [mailto:joe at perches.com]
> Sent: Friday, June 06, 2014 9:53 AM
> To: Vidya Sagar
> Cc: linux at arm.linux.org.uk; bhelgaas at google.com;
> wangyijing at huawei.com; thierry.reding at gmail.com;
> jason at lakedaemon.net; will.deacon at arm.com; Stephen Warren; Krishna
> Thota; sagar.tv at gmail.com; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org
> Subject: Re: [PATCH v2] ARM: fix debug prints relevant to PCI devices
> 
> On Fri, 2014-06-06 at 00:17 +0530, Vidya Sagar wrote:
> > * replaced printk with pr_info
> []
> > diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> []
> > @@ -354,9 +357,11 @@ void pcibios_fixup_bus(struct pci_bus *bus)
> >
> >  	/*
> >  	 * Report what we did for this bus
> > +	 * (only if the bus doesn't have even one PCIe device)
> >  	 */
> > -	printk(KERN_INFO "PCI: bus%d: Fast back to back transfers
> %sabled\n",
> > -		bus->number, (features & PCI_COMMAND_FAST_BACK) ?
> "en" : "dis");
> > +	if (!has_pcie_dev)
> > +		pr_info(KERN_INFO "PCI: bus%d: Fast back to back transfers
> %sabled\n",
> > +			bus->number, (features &
> PCI_COMMAND_FAST_BACK) ? "en" : "dis");
> 
> when you convert to pr_<level> you need to remove the KERN_<LEVEL>
> from the format string too.
> 
