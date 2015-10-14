From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Oct 2015 10:20 +0200
Subject: [PATCH v9 3/6] pci:host: Add Altera PCIe host controller driver
In-Reply-To: <1444790492-4051-4-git-send-email-lftan@altera.com>
References: <1444790492-4051-1-git-send-email-lftan@altera.com>
 <1444790492-4051-4-git-send-email-lftan@altera.com>
Message-ID: <6044983.WR9BTgsOaA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 October 2015 10:41:29 Ley Foon Tan wrote:
> +static int altera_pcie_remove(struct platform_device *pdev)
> +{
> +	struct altera_pcie *pcie = platform_get_drvdata(pdev);
> +
> +	altera_pcie_free_irq_domain(pcie);
> +	platform_set_drvdata(pdev, NULL);
> +	return 0;
> +}

I just noticed this. Does it actually work to unload the module
and tear down all the pci_dev structures in a safe way?

	Arnd
