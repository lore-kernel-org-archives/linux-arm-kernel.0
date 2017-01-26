From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed, 25 Jan 2017 17:22:34 -0800
Subject: [PATCH v3 13/24] platform: add video-multiplexer subdevice driver
In-Reply-To: <CABxcv=n1z7OwOctm_qmT8oBWSGK4tyvKBY6fWUOSZHfW1x=QUQ@mail.gmail.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-14-git-send-email-steve_longerbeam@mentor.com>
 <CABxcv=n1z7OwOctm_qmT8oBWSGK4tyvKBY6fWUOSZHfW1x=QUQ@mail.gmail.com>
Message-ID: <05f38c1c-bf6a-3be0-9aa9-c23a4ca24cdd@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/24/2017 04:44 AM, Javier Martinez Canillas wrote:
> Hello Steve,
>
> On Fri, Jan 6, 2017 at 11:11 PM, Steve Longerbeam <slongerbeam@gmail.com> wrote:
>> From: Philipp Zabel <p.zabel@pengutronix.de>
> [snip]
>
>> +config VIDEO_MULTIPLEXER
>> +       tristate "Video Multiplexer"
>> +       depends on VIDEO_V4L2_SUBDEV_API && MEDIA_CONTROLLER
> The driver can be build as a module...
>
>> +
>> +static const struct of_device_id vidsw_dt_ids[] = {
>> +       { .compatible = "video-multiplexer", },
>> +       { /* sentinel */ }
>> +};
>> +
> ... so you need a MODULE_DEVICE_TABLE(of, vidsw_dt_ids) here or
> otherwise module autoloading won't work.

Hi Javier, thanks for catching, done.

Steve
