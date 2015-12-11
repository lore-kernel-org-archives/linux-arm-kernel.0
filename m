From: j.anaszewski@samsung.com (Jacek Anaszewski)
Date: Fri, 11 Dec 2015 15:04:52 +0100
Subject: [PATCH 03/10] media framework: rename pads init function to
 media_entity_pads_init()
In-Reply-To: <063476f381aebf981106b7d134348a0a9acc67cc.1449840443.git.mchehab@osg.samsung.com>
References: <cover.1449840443.git.mchehab@osg.samsung.com>
 <063476f381aebf981106b7d134348a0a9acc67cc.1449840443.git.mchehab@osg.samsung.com>
Message-ID: <566AD804.5040403@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2015 02:34 PM, Mauro Carvalho Chehab wrote:
> With the MC next gen rework, what's left for media_entity_init()
> is to just initialize the PADs. However, certain devices, like
> a FLASH led/light doesn't have any input or output PAD.
>
> So, there's no reason why calling media_entity_init() would be
> mandatory. Also, despite its name, what this function actually
> does is to initialize the PADs data. So, rename it to
> media_entity_pads_init() in order to reflect that.
>
> The media entity actual init happens during entity register,
> at media_device_register_entity(). We should move init of
> num_links and num_backlinks to it.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
[...]
> diff --git a/drivers/media/v4l2-core/v4l2-flash-led-class.c b/drivers/media/v4l2-core/v4l2-flash-led-class.c
> index 5c686a24712b..13d5a36bc5d8 100644
> --- a/drivers/media/v4l2-core/v4l2-flash-led-class.c
> +++ b/drivers/media/v4l2-core/v4l2-flash-led-class.c
> @@ -651,7 +651,7 @@ struct v4l2_flash *v4l2_flash_init(
>   	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
>   	strlcpy(sd->name, config->dev_name, sizeof(sd->name));
>
> -	ret = media_entity_init(&sd->entity, 0, NULL);
> +	ret = media_entity_pads_init(&sd->entity, 0, NULL);
>   	if (ret < 0)
>   		return ERR_PTR(ret);
>

For this part:

Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>

-- 
Best Regards,
Jacek Anaszewski
