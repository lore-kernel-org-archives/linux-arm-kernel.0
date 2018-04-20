From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 20 Apr 2018 09:23:16 +0200
Subject: [PATCH v2 01/10] media: v4l2-ctrls: Add missing v4l2 ctrl unlock
In-Reply-To: <20180419154124.17512-2-paul.kocialkowski@bootlin.com>
References: <20180419154124.17512-1-paul.kocialkowski@bootlin.com>
 <20180419154124.17512-2-paul.kocialkowski@bootlin.com>
Message-ID: <20180420072316.sifritx54mppgwz3@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2018 at 05:41:15PM +0200, Paul Kocialkowski wrote:
> This adds a missing v4l2_ctrl_unlock call that is required to avoid
> deadlocks.

Maybe you can explain what the deadlock scenario is?

> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/media/v4l2-core/v4l2-ctrls.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
> index f67e9f5531fa..ba05a8b9a095 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
> @@ -3614,10 +3614,12 @@ void v4l2_ctrl_request_complete(struct media_request *req,
>  			continue;
>  
>  		v4l2_ctrl_lock(ctrl);
> +
>  		if (ref->req)
>  			ptr_to_ptr(ctrl, ref->req->p_req, ref->p_req);
>  		else
>  			ptr_to_ptr(ctrl, ctrl->p_cur, ref->p_req);
> +

I'm not sure that this is relevant in this patch.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180420/6b564f27/attachment.sig>
