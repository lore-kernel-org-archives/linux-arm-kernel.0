From: broonie@kernel.org (Mark Brown)
Date: Tue, 21 Feb 2017 09:47:37 -0800
Subject: next-20170221 build: 2 failures 9 warnings (next-20170221)
In-Reply-To: <E1cg6WK-0000gP-QT@optimist>
References: <E1cg6WK-0000gP-QT@optimist>
Message-ID: <20170221174737.2gf63ywzdjrh33ub@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2017 at 09:14:04AM +0000, Build bot for Mark Brown wrote:

Today's -next fails to build an ARM allmodconfig due to:

> 	arm-allmodconfig
> ../drivers/pci/dwc/pci-exynos.c:132:25: error: 'struct exynos_pcie' has no member named 'pp'
> ../drivers/pci/dwc/pci-exynos.c:162:25: error: 'struct exynos_pcie' has no member named 'pp'
> ../drivers/pci/dwc/pci-exynos.c:185:25: error: 'struct exynos_pcie' has no member named 'pp'

due to b09d4ac91a3934e9 (PCI: dwc: all: Split struct pcie_port into
host-only and core structures) which replaced the struct member pp with
*pci but has missed some users.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170221/778ec710/attachment.sig>
