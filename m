From: monstr@monstr.eu (Michal Simek)
Date: Wed, 01 Oct 2014 10:25:37 +0200
Subject: [PATCH] net: xilinx: Remove unnecessary ether_setup after
 alloc_etherdev
In-Reply-To: <d43b465eca3e2a53c930f6e02dc4ac8b3c084693.1412143216.git.michal.simek@xilinx.com>
References: <d43b465eca3e2a53c930f6e02dc4ac8b3c084693.1412143216.git.michal.simek@xilinx.com>
Message-ID: <542BBA81.2000406@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2014 08:00 AM, Michal Simek wrote:
> From: Subbaraya Sundeep Bhatta <subbaraya.sundeep.bhatta@xilinx.com>
> 
> Calling ether_setup is redundant since alloc_etherdev calls it.
> 
> Signed-off-by: Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  drivers/net/ethernet/xilinx/ll_temac_main.c       | 1 -
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
> index fda5891835d4..629077050fce 100644
> --- a/drivers/net/ethernet/xilinx/ll_temac_main.c
> +++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
> @@ -1012,7 +1012,6 @@ static int temac_of_probe(struct platform_device *op)
>  	if (!ndev)
>  		return -ENOMEM;
> 
> -	ether_setup(ndev);
>  	platform_set_drvdata(op, ndev);
>  	SET_NETDEV_DEV(ndev, &op->dev);
>  	ndev->flags &= ~IFF_MULTICAST;  /* clear multicast */
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index c8fd94133ecd..4ea2d4e6f1d1 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -1485,7 +1485,6 @@ static int axienet_of_probe(struct platform_device *op)
>  	if (!ndev)
>  		return -ENOMEM;
> 
> -	ether_setup(ndev);
>  	platform_set_drvdata(op, ndev);
> 
>  	SET_NETDEV_DEV(ndev, &op->dev);
> --
> 1.8.2.3
> 

Please ignore this one it is already applied for axienet.
Will send v2 just for ll_temac.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141001/355efe0e/attachment.sig>
