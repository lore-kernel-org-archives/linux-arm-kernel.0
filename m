From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Mon, 7 May 2018 15:50:29 +0200
Subject: [PATCH v3 09/14] media: v4l: Add definition for Allwinner's
 MB32-tiled NV12 format
In-Reply-To: <20180507124500.20434-10-paul.kocialkowski@bootlin.com>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
 <20180507124500.20434-10-paul.kocialkowski@bootlin.com>
Message-ID: <8b9aa08f-d514-5680-3d10-91e1a72c1e82@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/18 14:44, Paul Kocialkowski wrote:
> This introduces support for Allwinner's MB32-tiled NV12 format, where
> each plane is divided into macroblocks of 32x32 pixels. Hence, the size
> of each plane has to be aligned to 32 bytes. The pixels inside each
> macroblock are coded as they would be if the macroblock was a single
> plane, line after line.
> 
> The MB32-tiled NV12 format is used by the video engine on Allwinner
> platforms: it is the default format for decoded frames (and the only one
> available in the oldest supported platforms).
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  include/uapi/linux/videodev2.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index d8f9b59d90d7..242a6bfa1440 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -670,6 +670,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_Z16      v4l2_fourcc('Z', '1', '6', ' ') /* Depth data 16-bit */
>  #define V4L2_PIX_FMT_MT21C    v4l2_fourcc('M', 'T', '2', '1') /* Mediatek compressed block mode  */
>  #define V4L2_PIX_FMT_INZI     v4l2_fourcc('I', 'N', 'Z', 'I') /* Intel Planar Greyscale 10-bit and Depth 16-bit */
> +#define V4L2_PIX_FMT_MB32_NV12 v4l2_fourcc('M', 'N', '1', '2') /* Allwinner NV12 in 32x32 macroblocks */

Must be documented in the spec as well.

Regards,

	Hans

>  
>  /* 10bit raw bayer packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
>  #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */
> 
