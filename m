From: mchehab@osg.samsung.com (Mauro Carvalho Chehab)
Date: Mon, 14 Mar 2016 08:28:59 -0300
Subject: [PATCH] media: v4l2-compat-ioctl32: fix missing reserved field
 copy in put_v4l2_create32
In-Reply-To: <1457952106-38215-1-git-send-email-tiffany.lin@mediatek.com>
References: <1457952106-38215-1-git-send-email-tiffany.lin@mediatek.com>
Message-ID: <20160314082859.31340fb6@recife.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Mon, 14 Mar 2016 18:41:46 +0800
Tiffany Lin <tiffany.lin@mediatek.com> escreveu:

> Change-Id: Idac449fae5059a3ce255340e6da491f8bd83af7a

We don't need change-id at the Kernel, but we do need a proper patch
description.

Regards,
Mauro

> ---
>  drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
> index f38c076..109f687 100644
> --- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
> +++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
> @@ -280,7 +280,8 @@ static int put_v4l2_format32(struct v4l2_format *kp, struct v4l2_format32 __user
>  static int put_v4l2_create32(struct v4l2_create_buffers *kp, struct v4l2_create_buffers32 __user *up)
>  {
>  	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_create_buffers32)) ||
> -	    copy_to_user(up, kp, offsetof(struct v4l2_create_buffers32, format)))
> +	    copy_to_user(up, kp, offsetof(struct v4l2_create_buffers32, format)) ||
> +	    copy_to_user(up->reserved, kp->reserved, sizeof(kp->reserved)))
>  		return -EFAULT;
>  	return __put_v4l2_format32(&kp->format, &up->format);
>  }
