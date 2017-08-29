From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 29 Aug 2017 08:00:20 +0200
Subject: [PATCH] fpga: make xlnx_pr_decoupler_br_ops const
In-Reply-To: <1503941531-17977-1-git-send-email-bhumirks@gmail.com>
References: <1503941531-17977-1-git-send-email-bhumirks@gmail.com>
Message-ID: <78e2ed1d-ea20-eb68-b6b4-d993a98984a6@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.8.2017 19:32, Bhumika Goyal wrote:
> Make this const as it is only passed to a const argument of the function
> fpga_bridge_register.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  drivers/fpga/xilinx-pr-decoupler.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> index e359930..0d77430 100644
> --- a/drivers/fpga/xilinx-pr-decoupler.c
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -79,7 +79,7 @@ static int xlnx_pr_decoupler_enable_show(struct fpga_bridge *bridge)
>  	return !status;
>  }
>  
> -static struct fpga_bridge_ops xlnx_pr_decoupler_br_ops = {
> +static const struct fpga_bridge_ops xlnx_pr_decoupler_br_ops = {
>  	.enable_set = xlnx_pr_decoupler_enable_set,
>  	.enable_show = xlnx_pr_decoupler_enable_show,
>  };
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
