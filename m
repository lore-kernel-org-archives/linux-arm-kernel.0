From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Sun, 22 Jan 2017 15:38:47 +0800
Subject: [PATCH] PCI: rockchip: mark PM functions as __maybe_unused
In-Reply-To: <20170120162450.3690225-1-arnd@arndb.de>
References: <20170120162450.3690225-1-arnd@arndb.de>
Message-ID: <41135715-6f07-9c85-0b78-c66a37607b92@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 2017/1/21 0:24, Arnd Bergmann wrote:
> When CONFIG_PM_SLEEP is disabled, we get harmless build warnings:
>
> host/pcie-rockchip.c:1267:12: error: 'rockchip_pcie_resume_noirq' defined but not used [-Werror=unused-function]
> host/pcie-rockchip.c:1240:12: error: 'rockchip_pcie_suspend_noirq' defined but not used [-Werror=unused-function]
>
> Marking both functions as __maybe_unused avoids the warning without
> the need for #ifdef around them.

Sorry for introducing this warning, and thanks for fixing it.

Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

>
> Fixes: 013dd3d5e183 ("PCI: rockchip: Add system PM support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pci/host/pcie-rockchip.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 0d6e8ee5b017..b975116d2b03 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -1237,7 +1237,7 @@ static int rockchip_pcie_wait_l2(struct rockchip_pcie *rockchip)
>  	return 0;
>  }
>
> -static int rockchip_pcie_suspend_noirq(struct device *dev)
> +static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
>  	int ret;
> @@ -1264,7 +1264,7 @@ static int rockchip_pcie_suspend_noirq(struct device *dev)
>  	return ret;
>  }
>
> -static int rockchip_pcie_resume_noirq(struct device *dev)
> +static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
>  {
>  	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
>  	int err;
>


-- 
Best Regards
Shawn Lin
