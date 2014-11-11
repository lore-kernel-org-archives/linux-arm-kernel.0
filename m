From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Tue, 11 Nov 2014 22:33:44 +0700
Subject: [PATCH 2/2] PCI: generic: Add set_msi_parent callback
In-Reply-To: <20141111112424.GB16265@arm.com>
References: <1415647480-3320-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1415647480-3320-3-git-send-email-suravee.suthikulpanit@amd.com>
 <20141111112424.GB16265@arm.com>
Message-ID: <54622C58.1040701@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/14 18:24, Will Deacon wrote:
>> @@ -313,6 +324,9 @@ static int gen_pci_probe(struct platform_device *pdev)
>> >  		return err;
>> >  	}
>> >
>> >+	pci->mchip = of_pci_find_msi_chip_by_node(of_parse_phandle(np,
>> >+						  "msi-parent", 0));
> This bit should be in the generic of_pci.c code and not duplicated for
> each host controller.
>
> Will

I forgot to mention and include in the patch that we are also 
introducing "msi-parent" binding to the generic host controller. I'll do 
that in v2.

Unless this is something that we would like to add to the generic OF 
binding for PCI, I think it should be in the pci-host-generic.c.

Thanks,
Suravee
