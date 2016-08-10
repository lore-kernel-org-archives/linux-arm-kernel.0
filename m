From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 10 Aug 2016 11:29:13 +0200
Subject: [PATCH 1/1] xilinx: check return value of class_create
In-Reply-To: <1470816502-16802-1-git-send-email-yizhouzhou@ict.ac.cn>
References: <1470816502-16802-1-git-send-email-yizhouzhou@ict.ac.cn>
Message-ID: <d137c894-a0cb-6a2f-92ac-3148fe49bf58@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.8.2016 10:08, yizhouzhou at ict.ac.cn wrote:
> From: Zhouyi Zhou <yizhouzhou@ict.ac.cn>
> 
> 	 return value of class_create should be considered in
> module init function.
> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> ---
>  drivers/char/xilinx_hwicap/xilinx_hwicap.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
> index c07dfe5..3877b46 100644
> --- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
> +++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
> @@ -854,6 +854,9 @@ static int __init hwicap_module_init(void)
>  	int retval;
>  
>  	icap_class = class_create(THIS_MODULE, "xilinx_config");
> +	if (IS_ERR(icap_class))
> +		return PTR_ERR(icap_class);
> +
>  	mutex_init(&icap_sem);
>  
>  	devt = MKDEV(XHWICAP_MAJOR, XHWICAP_MINOR);
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
