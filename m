From: k.debski@samsung.com (Kamil Debski)
Date: Thu, 14 Jan 2016 18:25:26 +0100
Subject: [PATCH v3 2/2] s5p-mfc: add the support of
 V4L2_CID_MPEG_VIDEO_FORCE_I_FRAME.
In-Reply-To: <1452783007-80883-3-git-send-email-wuchengli@chromium.org>
References: <1452783007-80883-1-git-send-email-wuchengli@chromium.org>
 <1452783007-80883-3-git-send-email-wuchengli@chromium.org>
Message-ID: <00b301d14ef0$8f51df00$adf59d00$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> From: Wu-Cheng Li [mailto:wuchengli at chromium.org]
> Sent: Thursday, January 14, 2016 3:50 PM
> To: pawel at osciak.com; mchehab at osg.samsung.com; hverkuil at xs4all.nl;
> k.debski at samsung.com; crope at iki.fi; standby24x7 at gmail.com;
> wuchengli at chromium.org; nicolas.dufresne at collabora.com;
> ricardo.ribalda at gmail.com; ao2 at ao2.it; bparrot at ti.com;
> kyungmin.park at samsung.com; jtp.park at samsung.com
> Cc: linux-media at vger.kernel.org; linux-kernel at vger.kernel.org; linux-
> api at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> tiffany.lin at mediatek.com; djkurtz at chromium.org
> Subject: [PATCH v3 2/2] s5p-mfc: add the support of
> V4L2_CID_MPEG_VIDEO_FORCE_I_FRAME.

However simple the patch is, please do provide a commit message.
Please write something. 

Best wishes,
Kamil

> Signed-off-by: Wu-Cheng Li <wuchengli@chromium.org>
> ---
>  drivers/media/platform/s5p-mfc/s5p_mfc_enc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
> b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
> index 0434f02..974b4c5 100644
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
> @@ -212,6 +212,14 @@ static struct mfc_control controls[] = {
>  		.menu_skip_mask = 0,
>  	},
>  	{
> +		.id = V4L2_CID_MPEG_VIDEO_FORCE_I_FRAME,
> +		.type = V4L2_CTRL_TYPE_BUTTON,
> +		.minimum = 0,
> +		.maximum = 0,
> +		.step = 0,
> +		.default_value = 0,
> +	},
> +	{
>  		.id = V4L2_CID_MPEG_VIDEO_VBV_SIZE,
>  		.type = V4L2_CTRL_TYPE_INTEGER,
>  		.minimum = 0,
> @@ -1423,6 +1431,10 @@ static int s5p_mfc_enc_s_ctrl(struct v4l2_ctrl
*ctrl)
>  	case V4L2_CID_MPEG_MFC51_VIDEO_FORCE_FRAME_TYPE:
>  		ctx->force_frame_type = ctrl->val;
>  		break;
> +	case V4L2_CID_MPEG_VIDEO_FORCE_I_FRAME:
> +		ctx->force_frame_type =
> +
> 	V4L2_MPEG_MFC51_VIDEO_FORCE_FRAME_TYPE_I_FRAME;
> +		break;
>  	case V4L2_CID_MPEG_VIDEO_VBV_SIZE:
>  		p->vbv_size = ctrl->val;
>  		break;
> --
> 2.6.0.rc2.230.g3dd15c0
