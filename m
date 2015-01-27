From: horms@verge.net.au (Simon Horman)
Date: Tue, 27 Jan 2015 09:58:09 +0900
Subject: [PATCH v2 1/3] ARM: shmobile: armadillo800eva: Properly specify
 HDMI audio link format
In-Reply-To: <1421847492-8857-1-git-send-email-lars@metafoo.de>
References: <1421847492-8857-1-git-send-email-lars@metafoo.de>
Message-ID: <20150127005808.GB29710@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 02:38:10PM +0100, Lars-Peter Clausen wrote:
> The DAI link format should be specified for the whole link rather than just
> one component on the link. So move the format specification for the HDMI
> audio link from the CPU component to the link itself.
> 
> Since the sh-mobile-hdmi DAI driver doesn't implement the set_fmt() callback
> in this case there is no functional difference between only specifying the
> the format for the CPU side or for the whole link, but the later it will
> allow us to remove support for just specifying the format for one component.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> No changes since v1.

Morimoto-san,

could you provide a review of this patch?

> ---
>  arch/arm/mach-shmobile/board-armadillo800eva.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
> index 6d949f1..75de26c 100644
> --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
> @@ -1040,9 +1040,9 @@ static struct asoc_simple_card_info fsi2_hdmi_info = {
>  	.card		= "FSI2B-HDMI",
>  	.codec		= "sh-mobile-hdmi",
>  	.platform	= "sh_fsi2",
> +	.daifmt		= SND_SOC_DAIFMT_CBS_CFS,
>  	.cpu_dai = {
>  		.name	= "fsib-dai",
> -		.fmt	= SND_SOC_DAIFMT_CBS_CFS,
>  	},
>  	.codec_dai = {
>  		.name = "sh_mobile_hdmi-hifi",
> -- 
> 1.8.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
