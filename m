From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Mon, 27 Nov 2017 11:17:50 +0100
Subject: [PATCH v2 01/11] media: videodev2.h, v4l2-ioctl: add rkisp1 meta
 buffer format
In-Reply-To: <20171124023706.5702-2-jacob-chen@iotwrt.com>
References: <20171124023706.5702-1-jacob-chen@iotwrt.com>
 <20171124023706.5702-2-jacob-chen@iotwrt.com>
Message-ID: <cae70249-d558-0e6d-19d4-1289630d20e7@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/2017 03:36 AM, Jacob Chen wrote:
> From: Shunqian Zheng <zhengsq@rock-chips.com>
> 
> Add the Rockchip ISP1 specific processing parameter format
> V4L2_META_FMT_RK_ISP1_PARAMS and metadata format
> V4L2_META_FMT_RK_ISP1_STAT_3A for 3A.

These formats are not documented in the V4L2 spec. I think it is documented in
rkisp1-config.h, so you need to add something to meta-formats.rst. It's OK to
refer to that header, as long as it is clear where the documentation of the
format can be found.

Regards,

	Hans

> 
> Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
> Signed-off-by: Jacob Chen <jacob2.chen@rock-chips.com>
> ---
>  drivers/media/v4l2-core/v4l2-ioctl.c | 2 ++
>  include/uapi/linux/videodev2.h       | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index d6587b3ec33e..0604ae9ea444 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1252,6 +1252,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  	case V4L2_TCH_FMT_TU08:		descr = "8-bit unsigned touch data"; break;
>  	case V4L2_META_FMT_VSP1_HGO:	descr = "R-Car VSP1 1-D Histogram"; break;
>  	case V4L2_META_FMT_VSP1_HGT:	descr = "R-Car VSP1 2-D Histogram"; break;
> +	case V4L2_META_FMT_RK_ISP1_PARAMS:	descr = "Rockchip ISP1 3A params"; break;
> +	case V4L2_META_FMT_RK_ISP1_STAT_3A:	descr = "Rockchip ISP1 3A statistics"; break;
>  
>  	default:
>  		/* Compressed formats */
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 7c871291c1fa..961545e64c12 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -691,6 +691,10 @@ struct v4l2_pix_format {
>  #define V4L2_META_FMT_VSP1_HGO    v4l2_fourcc('V', 'S', 'P', 'H') /* R-Car VSP1 1-D Histogram */
>  #define V4L2_META_FMT_VSP1_HGT    v4l2_fourcc('V', 'S', 'P', 'T') /* R-Car VSP1 2-D Histogram */
>  
> +/* Vendor specific - used for IPU3 camera sub-system */
> +#define V4L2_META_FMT_RK_ISP1_PARAMS	v4l2_fourcc('R', 'K', '1', 'P') /* Rockchip ISP1 params */
> +#define V4L2_META_FMT_RK_ISP1_STAT_3A	v4l2_fourcc('R', 'K', '1', 'S') /* Rockchip ISP1 3A statistics */
> +
>  /* priv field value to indicates that subsequent fields are valid. */
>  #define V4L2_PIX_FMT_PRIV_MAGIC		0xfeedcafe
>  
> 
