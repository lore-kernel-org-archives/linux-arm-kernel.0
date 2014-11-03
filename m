From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 3 Nov 2014 10:49:50 +0000
Subject: [RFC PATCH 2/2] arm: pcibios: move to generic PCI domains
In-Reply-To: <5456FB07.40002@huawei.com>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1414669490-1217-3-git-send-email-lorenzo.pieralisi@arm.com>
 <5456FB07.40002@huawei.com>
Message-ID: <20141103104950.GA30519@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 03, 2014 at 03:48:23AM +0000, Yijing Wang wrote:
> On 2014/10/30 19:44, Lorenzo Pieralisi wrote:

[...]

> > diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> > index 7fc4278..f19f627 100644
> > --- a/arch/arm/include/asm/mach/pci.h
> > +++ b/arch/arm/include/asm/mach/pci.h
> > @@ -44,9 +44,6 @@ struct hw_pci {
> >   * Per-controller structure
> >   */
> 
> domain in hw_pci also should be clean up, right ?
> 
> 
> struct hw_pci {
> #ifdef CONFIG_PCI_DOMAINS
> 	int		domain;
> #endif
> 	struct pci_ops	*ops;
> 	int		nr_controllers;
> 	void		**private_data;

Yes, thanks for spotting that.

Lorenzo
