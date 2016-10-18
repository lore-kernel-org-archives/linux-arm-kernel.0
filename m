From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Tue, 18 Oct 2016 08:50:28 +0800
Subject: [PATCH -next] PCI: rockchip: Add missing of_node_put() in
 rockchip_pcie_init_irq_domain()
In-Reply-To: <1476716242-31684-1-git-send-email-weiyj.lk@gmail.com>
References: <1476716242-31684-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <87c39739-c9d0-b307-5256-591ef7324ffa@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2016/10/17 22:57, Wei Yongjun ??:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> This node pointer is returned by of_get_next_child() with refcount
> incremented in this function. of_node_put() on it before exitting
> this function on error.
>
> This is detected by Coccinelle semantic patch.

Thanks for fixing this.

Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/pci/host/pcie-rockchip.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index e0b22da..ab88859 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -949,6 +949,7 @@ static int rockchip_pcie_init_irq_domain(struct rockchip_pcie *rockchip)
>  						    &intx_domain_ops, rockchip);
>  	if (!rockchip->irq_domain) {
>  		dev_err(dev, "failed to get a INTx IRQ domain\n");
> +		of_node_put(intc);
>  		return -EINVAL;
>  	}
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards
Shawn Lin
