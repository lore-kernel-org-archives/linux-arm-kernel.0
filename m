From: jorge.ramirez-ortiz@linaro.org (Jorge Ramirez-Ortiz)
Date: Tue, 03 Mar 2015 10:39:29 -0500
Subject: [PATCH 2/2] drivers/tty: pl011: read fifo size from OF if present
In-Reply-To: <1424290069-8760-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <amba uarts - arm type uarts fifo size provided by device tree>
 <1424290069-8760-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1424290069-8760-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
Message-ID: <54F5D5B1.9060101@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2015 03:07 PM, Jorge Ramirez-Ortiz wrote:
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  drivers/tty/serial/amba-pl011.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 02016fc..c6a2dd8 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -84,6 +84,11 @@ struct vendor_data {
>  
>  static unsigned int get_fifosize_arm(struct amba_device *dev)
>  {
> +	u32 val;
> +
> +	if (!of_property_read_u32(dev->dev.of_node, "fifo-size", &val))
> +		return val;
> +
>  	return amba_rev(dev) < 3 ? 16 : 32;
>  }
>  

just following up on this patch. is anything else required?
