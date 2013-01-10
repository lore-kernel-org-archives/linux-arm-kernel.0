From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 10 Jan 2013 16:54:30 -0700
Subject: [PATCH 10/14] PCI: tegra: Move PCIe driver to drivers/pci/host
In-Reply-To: <1357764194-12677-11-git-send-email-thierry.reding@avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <1357764194-12677-11-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <50EF54B6.6010100@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/2013 01:43 PM, Thierry Reding wrote:
> Move the PCIe driver from arch/arm/mach-tegra into the drivers/pci/host
> directory. The motivation is to collect various host controller drivers
> in the same location in order to facilitate refactoring.
> 
> The Tegra PCIe driver has been largely rewritten, both in order to turn
> it into a proper platform driver and to add MSI (based on code by
> Krishna Kishore <kthota@nvidia.com>) as well as device tree support.

This driver doesn't compile unless CONFIG_PCI_MSI is also enabled.
Should it select that, or contain a few ifdefs?

drivers/pci/host/pci-tegra.c:900: undefined reference to `write_msi_msg'
