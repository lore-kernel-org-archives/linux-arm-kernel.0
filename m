From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 11 Mar 2017 00:32:23 +0100
Subject: [PATCH v5 22/39] media: Add userspace header file for i.MX
In-Reply-To: <1489121599-23206-23-git-send-email-steve_longerbeam@mentor.com>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <1489121599-23206-23-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170310233223.GD6540@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> diff --git a/include/uapi/media/Kbuild b/include/uapi/media/Kbuild
> index aafaa5a..fa78958 100644
> --- a/include/uapi/media/Kbuild
> +++ b/include/uapi/media/Kbuild
> @@ -1 +1,2 @@
>  # UAPI Header export list
> +header-y += imx.h
> diff --git a/include/uapi/media/imx.h b/include/uapi/media/imx.h
> new file mode 100644
> index 0000000..f573de4
> --- /dev/null
> +++ b/include/uapi/media/imx.h
> @@ -0,0 +1,21 @@
> +/*
> + * Copyright (c) 2014-2015 Mentor Graphics Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the
> + * License, or (at your option) any later version
> + */
> +
> +#ifndef __UAPI_MEDIA_IMX_H__
> +#define __UAPI_MEDIA_IMX_H__
> +
> +enum imx_ctrl_id {
> +	V4L2_CID_IMX_FIM_ENABLE = (V4L2_CID_USER_IMX_BASE + 0),
> +	V4L2_CID_IMX_FIM_NUM,
> +	V4L2_CID_IMX_FIM_TOLERANCE_MIN,
> +	V4L2_CID_IMX_FIM_TOLERANCE_MAX,
> +	V4L2_CID_IMX_FIM_NUM_SKIP,
> +};
> +

Should this #include something so that if userland includes it, it
will not get compile error?

Should there be some documentation of userland API?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170311/fc0feec7/attachment.sig>
