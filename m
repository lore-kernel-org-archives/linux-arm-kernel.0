From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Fri, 9 Jun 2017 16:02:54 -0700
Subject: [PATCH v8 19/34] media: Add i.MX media core driver
In-Reply-To: <1497014135.20356.12.camel@pengutronix.de>
References: <1496860453-6282-1-git-send-email-steve_longerbeam@mentor.com>
 <1496860453-6282-20-git-send-email-steve_longerbeam@mentor.com>
 <1497014135.20356.12.camel@pengutronix.de>
Message-ID: <0df57159-78de-52a7-4fc2-d53e4682c8bb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/09/2017 06:15 AM, Philipp Zabel wrote:
> On Wed, 2017-06-07 at 11:33 -0700, Steve Longerbeam wrote:
>> Add the core media driver for i.MX SOC.
>>
>> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
>>
>> Switch from the v4l2_of_ APIs to the v4l2_fwnode_ APIs.
>>
>> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
>>
>> Add the bayer formats to imx-media's list of supported pixel and bus
>> formats.
>>
>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>> ---
> [...]
>> diff --git a/drivers/staging/media/imx/imx-media-dev.c b/drivers/staging/media/imx/imx-media-dev.c
>> new file mode 100644
>> index 0000000..da694f6
>> --- /dev/null
>> +++ b/drivers/staging/media/imx/imx-media-dev.c
>> @@ -0,0 +1,666 @@
> [...]
>> +/*
>> + * adds given video device to given imx-media source pad vdev list.
>> + * Continues upstream from the pad entity's sink pads.
>> + */
>> +static int imx_media_add_vdev_to_pad(struct imx_media_dev *imxmd,
>> +				     struct imx_media_video_dev *vdev,
>> +				     struct media_pad *srcpad)
>> +{
>> +	struct media_entity *entity = srcpad->entity;
>> +	struct imx_media_subdev *imxsd;
>> +	struct imx_media_pad *imxpad;
>> +	struct media_link *link;
>> +	struct v4l2_subdev *sd;
>> +	int i, vdev_idx, ret;
>> +
>> +	if (!is_media_entity_v4l2_subdev(entity))
>> +		return -EINVAL;
> 
> Could we make this return 0, to just skip non-v4l2_subdev entities?
> Currently, imx_media_probe_complete silently fails with this -EINVAL if
> there is a tvp5150 connected due to the separate media entities that the
> tvp5150 driver creates for the input connectors (Composite0, for
> example).
> 

Right, I've made that change.

Steve
