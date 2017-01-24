From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 24 Jan 2017 09:44:12 -0300
Subject: [PATCH v3 13/24] platform: add video-multiplexer subdevice driver
In-Reply-To: <1483755102-24785-14-git-send-email-steve_longerbeam@mentor.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-14-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <CABxcv=n1z7OwOctm_qmT8oBWSGK4tyvKBY6fWUOSZHfW1x=QUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Steve,

On Fri, Jan 6, 2017 at 11:11 PM, Steve Longerbeam <slongerbeam@gmail.com> wrote:
> From: Philipp Zabel <p.zabel@pengutronix.de>

[snip]

>
> +config VIDEO_MULTIPLEXER
> +       tristate "Video Multiplexer"
> +       depends on VIDEO_V4L2_SUBDEV_API && MEDIA_CONTROLLER

The driver can be build as a module...

> +
> +static const struct of_device_id vidsw_dt_ids[] = {
> +       { .compatible = "video-multiplexer", },
> +       { /* sentinel */ }
> +};
> +

... so you need a MODULE_DEVICE_TABLE(of, vidsw_dt_ids) here or
otherwise module autoloading won't work.

Best regards,
Javier
