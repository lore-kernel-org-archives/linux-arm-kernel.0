From: nicolas.dufresne@gmail.com (Nicolas Dufresne)
Date: Wed, 13 Apr 2016 10:23:36 -0400
Subject: [PATCH 1/7] [media]: v4l: add Mediatek MT21 video block format
In-Reply-To: <1460548915-17536-2-git-send-email-tiffany.lin@mediatek.com>
References: <1460548915-17536-1-git-send-email-tiffany.lin@mediatek.com>
 <1460548915-17536-2-git-send-email-tiffany.lin@mediatek.com>
Message-ID: <1460557416.18956.3.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mercredi 13 avril 2016 ? 20:01 +0800, Tiffany Lin a ?crit?:
> From: Daniel Kurtz <djkurtz@chromium.org>
> 
> Mediatek video format is YVU8_420_2PLANE_PACK8_PROGRESSIVE.
> 
> Create V4L2_PIX_FMT_MT21 and DRM_FORMAT_MT21 to be consistent with
> V4L2_PIX_FMT_NV12 notation.
> 
> Signed-off-by: Tiffany Lin <tiffany.lin@mediatek.com>
> ---
> ?include/uapi/drm/drm_fourcc.h??|????1 +
> ?include/uapi/linux/videodev2.h |????2 ++

Might be better to split this patch.

> ?2 files changed, 3 insertions(+)
> 
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 0b69a77..a193905 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -116,6 +116,7 @@
> ?#define DRM_FORMAT_NV24		fourcc_code('N', 'V', '2', '4') /* non-subsampled Cr:Cb plane */
> ?#define DRM_FORMAT_NV42		fourcc_code('N', 'V', '4', '2') /* non-subsampled Cb:Cr plane */
> ?
> +#define DRM_FORMAT_MT21		fourcc_code('M', 'T', '2', '1') /* Mediatek Block Mode */

Please document the tiling format, don't just add a define here.

> ?/*
> ? * 3 plane YCbCr
> ? * index 0: Y plane, [7:0] Y
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index d0acd26..e9e3276 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -527,6 +527,8 @@ struct v4l2_pix_format {
> ?#define V4L2_PIX_FMT_HM12????v4l2_fourcc('H', 'M', '1', '2') /*??8??YUV 4:2:0 16x16 macroblocks */
> ?#define V4L2_PIX_FMT_M420????v4l2_fourcc('M', '4', '2', '0') /* 12??YUV 4:2:0 2 lines y, 1 line uv interleaved */
> ?
> +#define V4L2_PIX_FMT_MT21????v4l2_fourcc('M', 'T', '2', '1') /* Mediatek Block Mode??*/
> +

Same. On Linux Media side, there is docbook documentation where you can
explain in detail.

> ?/* two planes -- one Y, one Cr + Cb interleaved??*/
> ?#define V4L2_PIX_FMT_NV12????v4l2_fourcc('N', 'V', '1', '2') /* 12??Y/CbCr 4:2:0??*/
> ?#define V4L2_PIX_FMT_NV21????v4l2_fourcc('N', 'V', '2', '1') /* 12??Y/CrCb 4:2:0??*/
