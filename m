From: joe@perches.com (Joe Perches)
Date: Thu, 28 Jun 2018 04:04:24 -0700
Subject: [PATCH v2 2/5] net: emaclite: Simplify if-else statements
In-Reply-To: <1530171584-20673-3-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1530171584-20673-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1530171584-20673-3-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <fc15913c3800923ef35e9db9508cbb9f67d0525f.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-06-28 at 13:09 +0530, Radhey Shyam Pandey wrote:
> Remove else as it is not required with if doing a return.
> Fixes below checkpatch warning.
[]
> diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
[]
> @@ -1052,13 +1051,13 @@ static bool get_bool(struct platform_device *ofdev, const char *s)
>  {
>  	u32 *p = (u32 *)of_get_property(ofdev->dev.of_node, s, NULL);
>  
> -	if (p) {
> -		return (bool)*p;
> -	} else {
> +	if (!p) {
>  		dev_warn(&ofdev->dev, "Parameter %s not found,"
>  			"defaulting to false\n", s);

Please coalesce the format onto a single line
and add the missing space after the comma.

>  		return false;
>  	}
> +
> +	return (bool)*p;
>  }
>  
>  static const struct net_device_ops xemaclite_netdev_ops;
