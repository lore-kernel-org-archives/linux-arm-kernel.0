From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Thu, 16 Feb 2017 10:16:10 -0800
Subject: [PATCH v4 28/36] media: imx: csi: fix crop rectangle changes in
 set_fmt
In-Reply-To: <20170216110531.GJ27312@n2100.armlinux.org.uk>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-29-git-send-email-steve_longerbeam@mentor.com>
 <20170216110531.GJ27312@n2100.armlinux.org.uk>
Message-ID: <8285778f-ea44-a968-d2d1-b1a286edbfd8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/16/2017 03:05 AM, Russell King - ARM Linux wrote:
> On Wed, Feb 15, 2017 at 06:19:30PM -0800, Steve Longerbeam wrote:
>> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
>> index ae24b42..3cb97e2 100644
>> --- a/drivers/staging/media/imx/imx-media-csi.c
>> +++ b/drivers/staging/media/imx/imx-media-csi.c
>> @@ -531,6 +531,10 @@ static int csi_setup(struct csi_priv *priv)
>>
>>  	ipu_csi_set_window(priv->csi, &priv->crop);
>>
>> +	ipu_csi_set_downsize(priv->csi,
>> +			     priv->crop.width == 2 * outfmt->width,
>> +			     priv->crop.height == 2 * outfmt->height);
>> +
>
> This fails to build:
>
> ERROR: "ipu_csi_set_downsize" [drivers/staging/media/imx/imx-media-csi.ko] undefined!
>
> ipu_csi_set_downsize needs to be exported if we're going to use it in
> a module:
>

Yes I encountered the missing export too, forgot to mention it.
Philipp submitted a patch to dri-devel separately.

Steve
