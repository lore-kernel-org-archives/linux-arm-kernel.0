From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 21 Feb 2017 15:31:58 -0600
Subject: next-20170221 build: 2 failures 9 warnings (next-20170221)
In-Reply-To: <20170221174737.2gf63ywzdjrh33ub@sirena.org.uk>
References: <E1cg6WK-0000gP-QT@optimist>
 <20170221174737.2gf63ywzdjrh33ub@sirena.org.uk>
Message-ID: <20170221213158.GA26036@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2017 at 09:47:37AM -0800, Mark Brown wrote:
> On Tue, Feb 21, 2017 at 09:14:04AM +0000, Build bot for Mark Brown wrote:
> 
> Today's -next fails to build an ARM allmodconfig due to:
> 
> > 	arm-allmodconfig
> > ../drivers/pci/dwc/pci-exynos.c:132:25: error: 'struct exynos_pcie' has no member named 'pp'
> > ../drivers/pci/dwc/pci-exynos.c:162:25: error: 'struct exynos_pcie' has no member named 'pp'
> > ../drivers/pci/dwc/pci-exynos.c:185:25: error: 'struct exynos_pcie' has no member named 'pp'
> 
> due to b09d4ac91a3934e9 (PCI: dwc: all: Split struct pcie_port into
> host-only and core structures) which replaced the struct member pp with
> *pci but has missed some users.

Thanks a lot, Mark!

b09d4ac91a3934e9 converted all the users at the time, but 327847808474
("PCI: exynos: Refactor to make it easier to support other SoCs") from
another branch added some new uses, and I missed those when I merged the
branches together.  I think I fixed it but I can't build it personally.

Bjorn
