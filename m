From: minghsiu.tsai@mediatek.com (Minghsiu Tsai)
Date: Mon, 24 Oct 2016 19:47:31 +0800
Subject: [SPAM][PATCH 3/4] mtk_mdp_m2m: remove an unused struct
In-Reply-To: <624b0ea4550b90318ec2293d80b1caa5bafd2a35.1477058332.git.mchehab@s-opensource.com>
References: <cd14afdb178cf490e257368bc899c7a0c690d140.1477058332.git.mchehab@s-opensource.com>
 <624b0ea4550b90318ec2293d80b1caa5bafd2a35.1477058332.git.mchehab@s-opensource.com>
Message-ID: <1477309651.29543.22.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-10-21 at 11:59 -0200, Mauro Carvalho Chehab wrote:
> drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c:48:33: warning: ?mtk_mdp_size_align? defined but not used [-Wunused-variable]
>  static struct mtk_mdp_pix_align mtk_mdp_size_align = {
>                                  ^~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> ---
>  drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c b/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
> index 065502757133..33124a6c9951 100644
> --- a/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
> +++ b/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
> @@ -45,13 +45,6 @@ struct mtk_mdp_pix_limit {
>  	u16 target_rot_en_h;
>  };
>  
> -static struct mtk_mdp_pix_align mtk_mdp_size_align = {
> -	.org_w			= 16,
> -	.org_h			= 16,
> -	.target_w		= 2,
> -	.target_h		= 2,
> -};
> -

Hi Mauro,

The structure is used for the format V4L2_PIX_FMT_MT21C which is added
in the later patch.
"[media] media: mtk-mdp: support pixelformat V4L2_PIX_FMT_MT21C"

I just know checkpatch should be run patch by patch, so this warning
message will be generated without the MT21C patch.

I found all mtk-mdp patches have been merged in media tree, so is this
patch still needed?

If yes, remove 'mtk_mdp_size_align' in this patch, and re-added it in
the MT21C patch. 


minghsiu

>  static const struct mtk_mdp_fmt mtk_mdp_formats[] = {
>  	{
>  		.pixelformat	= V4L2_PIX_FMT_NV12M,
