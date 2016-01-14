From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Thu, 14 Jan 2016 09:56:46 +0100
Subject: [PATCH v2 2/2] s5p-mfc: add the support of
 V4L2_CID_MPEG_VIDEO_FORCE_I_FRAME.
In-Reply-To: <1452760439-35564-3-git-send-email-wuchengli@chromium.org>
References: <1452760439-35564-1-git-send-email-wuchengli@chromium.org>
 <1452760439-35564-3-git-send-email-wuchengli@chromium.org>
Message-ID: <569762CE.2000104@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/16 09:33, Wu-Cheng Li wrote:
> Signed-off-by: Wu-Cheng Li <wuchengli@chromium.org>
> ---
>  drivers/media/platform/s5p-mfc/s5p_mfc_enc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
> index 0434f02..de1d68d 100644
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
> @@ -212,6 +212,15 @@ static struct mfc_control controls[] = {
>  		.menu_skip_mask = 0,
>  	},
>  	{
> +		.id = V4L2_CID_MPEG_VIDEO_FORCE_I_FRAME,
> +		.type = V4L2_CTRL_TYPE_BUTTON,
> +		.name = "Force an I frame",

Drop the name: this is a standard control, so the name will be filled in from
v4l2-ctrls.c.

Regards,

	Hans

> +		.minimum = 0,
> +		.maximum = 0,
> +		.step = 0,
> +		.default_value = 0,
> +	},
> +	{
>  		.id = V4L2_CID_MPEG_VIDEO_VBV_SIZE,
>  		.type = V4L2_CTRL_TYPE_INTEGER,
>  		.minimum = 0,
> @@ -1423,6 +1432,10 @@ static int s5p_mfc_enc_s_ctrl(struct v4l2_ctrl *ctrl)
>  	case V4L2_CID_MPEG_MFC51_VIDEO_FORCE_FRAME_TYPE:
>  		ctx->force_frame_type = ctrl->val;
>  		break;
> +	case V4L2_CID_MPEG_VIDEO_FORCE_I_FRAME:
> +		ctx->force_frame_type
> +			= V4L2_MPEG_MFC51_VIDEO_FORCE_FRAME_TYPE_I_FRAME;
> +		break;
>  	case V4L2_CID_MPEG_VIDEO_VBV_SIZE:
>  		p->vbv_size = ctrl->val;
>  		break;
> 
