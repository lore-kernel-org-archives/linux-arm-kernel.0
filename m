From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Tue, 17 Nov 2015 20:33:49 +0100
Subject: [PATCH] PCI: iproc: hide CONFIG_PCIE_IPROC
In-Reply-To: <11420214.lrdhuUq0ZO@wuerfel>
References: <11420214.lrdhuUq0ZO@wuerfel>
Message-ID: <564B811D.4000401@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2015 05:08 PM, Arnd Bergmann wrote:
> PCIE_IPROC_BCMA does not require CONFIG_OF in Kconfig, but
> CONFIG_PCIE_IPROC does, so we can get a warning when building
> for an ARM platform without DT support:
> 
> warning: (PCIE_IPROC_PLATFORM && PCIE_IPROC_BCMA) selects PCIE_IPROC which has unmet direct dependencies (PCI && OF && (ARM || ARM64))
> 
> It turns out that CONFIG_PCIE_IPROC never needs to be enabled
> by a user anyway, we can simply rely on it being selected
> implictly through either PCIE_IPROC_PLATFORM or PCIE_IPROC_BCMA.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 4785ffbdc9b5 ("PCI: iproc: Add BCMA PCIe driver")
> 

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

Thanks for spotting and fixing this.

hauke
