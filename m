From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 13 Nov 2014 15:32:28 +0000
Subject: [PATCH 2/2] PCI: generic: Add set_msi_parent callback
In-Reply-To: <54622C58.1040701@amd.com>
References: <1415647480-3320-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1415647480-3320-3-git-send-email-suravee.suthikulpanit@amd.com>
 <20141111112424.GB16265@arm.com> <54622C58.1040701@amd.com>
Message-ID: <20141113153228.GC9726@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[CC'ing Arnd and RobH]

On Tue, Nov 11, 2014 at 03:33:44PM +0000, Suravee Suthikulpanit wrote:
> On 11/11/14 18:24, Will Deacon wrote:
> >> @@ -313,6 +324,9 @@ static int gen_pci_probe(struct platform_device *pdev)
> >> >  		return err;
> >> >  	}
> >> >
> >> >+	pci->mchip = of_pci_find_msi_chip_by_node(of_parse_phandle(np,
> >> >+						  "msi-parent", 0));
> > This bit should be in the generic of_pci.c code and not duplicated for
> > each host controller.
> >
> > Will
> 
> I forgot to mention and include in the patch that we are also 
> introducing "msi-parent" binding to the generic host controller. I'll do 
> that in v2.
> 
> Unless this is something that we would like to add to the generic OF 
> binding for PCI, I think it should be in the pci-host-generic.c.

Is there a reason why we do *not* want to add this property to generic OF
PCI binding ?

Thanks,
Lorenzo
