From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 12 May 2016 07:08:36 -0500
Subject: [PATCH V7 07/11] pci, acpi: Handle ACPI companion assignment.
In-Reply-To: <57345FDF.4000804@semihalf.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
 <1462893601-8937-8-git-send-email-tn@semihalf.com>
 <CAJZ5v0hM8WAr9GGku89zKgiVKt6ArHf=9CntRUyBjyMNUvie2A@mail.gmail.com>
 <20160511101101.GA16101@red-moon>
 <CAJZ5v0hgw929W5PjF0PqT+ssiOHd8TeJoSQcz4NUiAovZY2pfQ@mail.gmail.com>
 <20160511224314.GD28812@localhost> <57345FDF.4000804@semihalf.com>
Message-ID: <20160512120836.GF28812@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2016 at 12:50:07PM +0200, Tomasz Nowicki wrote:
> On 12.05.2016 00:43, Bjorn Helgaas wrote:

> >@@ -70,9 +71,11 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
> >  	cfg->res.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> >  	cfg->res.name = "PCI ECAM";
> >
> >-	err = request_resource(&iomem_resource, &cfg->res);
> >-	if (err) {
> >-		dev_err(dev, "request ECAM res %pR failed\n", &cfg->res);
> >+	conflict = request_resource(&iomem_resource, &cfg->res);
> 
> We need request_resource_conflict here then:
> -	conflict = request_resource(&iomem_resource, &cfg->res);
> +	conflict = request_resource_conflict(&iomem_resource, &cfg->res);

Whoops, fixed, thanks!
