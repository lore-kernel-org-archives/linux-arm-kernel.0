From: niklas.soderlund@ragnatech.se (Niklas =?iso-8859-1?Q?S=F6derlund?=)
Date: Mon, 4 Jun 2018 14:08:11 +0200
Subject: [PATCH v3 3/8] media: v4l2-fwnode: parse 'data-enable-active' prop
In-Reply-To: <1527606359-19261-4-git-send-email-jacopo+renesas@jmondi.org>
References: <1527606359-19261-1-git-send-email-jacopo+renesas@jmondi.org>
 <1527606359-19261-4-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <20180604120811.GD19674@bigcity.dyn.berto.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacopo,

Thanks for your patch.

On 2018-05-29 17:05:54 +0200, Jacopo Mondi wrote:
> Parse the newly defined 'data-enable-active' property in parallel endpoint
> parsing function.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

> 
> ---
> v3:
> - new patch
> ---
>  drivers/media/v4l2-core/v4l2-fwnode.c | 4 ++++
>  include/media/v4l2-mediabus.h         | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
> index 3f77aa3..6105191 100644
> --- a/drivers/media/v4l2-core/v4l2-fwnode.c
> +++ b/drivers/media/v4l2-core/v4l2-fwnode.c
> @@ -154,6 +154,10 @@ static void v4l2_fwnode_endpoint_parse_parallel_bus(
>  		flags |= v ? V4L2_MBUS_VIDEO_SOG_ACTIVE_HIGH :
>  			V4L2_MBUS_VIDEO_SOG_ACTIVE_LOW;
> 
> +	if (!fwnode_property_read_u32(fwnode, "data-enable-active", &v))
> +		flags |= v ? V4L2_MBUS_DATA_ENABLE_HIGH :
> +			V4L2_MBUS_DATA_ENABLE_LOW;
> +
>  	bus->flags = flags;
> 
>  }
> diff --git a/include/media/v4l2-mediabus.h b/include/media/v4l2-mediabus.h
> index 4d8626c..4bbb5f3 100644
> --- a/include/media/v4l2-mediabus.h
> +++ b/include/media/v4l2-mediabus.h
> @@ -45,6 +45,8 @@
>  /* Active state of Sync-on-green (SoG) signal, 0/1 for LOW/HIGH respectively. */
>  #define V4L2_MBUS_VIDEO_SOG_ACTIVE_HIGH		BIT(12)
>  #define V4L2_MBUS_VIDEO_SOG_ACTIVE_LOW		BIT(13)
> +#define V4L2_MBUS_DATA_ENABLE_HIGH		BIT(14)
> +#define V4L2_MBUS_DATA_ENABLE_LOW		BIT(15)
> 
>  /* Serial flags */
>  /* How many lanes the client can use */
> --
> 2.7.4
> 

-- 
Regards,
Niklas S?derlund
