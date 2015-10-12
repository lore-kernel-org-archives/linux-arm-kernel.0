From: mchehab@osg.samsung.com (Mauro Carvalho Chehab)
Date: Mon, 12 Oct 2015 12:58:06 -0300
Subject: [PATCH 1/1] media: Correctly determine whether an entity is a
 sub-device
In-Reply-To: <1444664303-18454-1-git-send-email-sakari.ailus@iki.fi>
References: <20151011215625.779630d9@recife.lan>
 <1444664303-18454-1-git-send-email-sakari.ailus@iki.fi>
Message-ID: <20151012125806.65ad436a@recife.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Mon, 12 Oct 2015 18:38:23 +0300
Sakari Ailus <sakari.ailus@iki.fi> escreveu:

> If the function of an entity is not one of the pre-defined ones, it is not
> correctly recognised as a V4L2 sub-device.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  include/media/media-entity.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/media/media-entity.h b/include/media/media-entity.h
> index a60872a..76e9a124 100644
> --- a/include/media/media-entity.h
> +++ b/include/media/media-entity.h
> @@ -328,6 +328,7 @@ static inline bool is_media_entity_v4l2_subdev(struct media_entity *entity)
>  	case MEDIA_ENT_F_LENS:
>  	case MEDIA_ENT_F_ATV_DECODER:
>  	case MEDIA_ENT_F_TUNER:
> +	case MEDIA_ENT_F_V4L2_SUBDEV_UNKNOWN:
>  		return true;

OK.

Reviewed-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

>  
>  	default:
