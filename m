From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Mon, 11 Jul 2016 09:31:25 +0800
Subject: [alsa-devel] [PATCH -next v2] ASoC: mediatek: mt2701: fix non
 static symbol warning
In-Reply-To: <1467985621-13755-1-git-send-email-weiyj_lk@163.com>
References: <1467985293-9041-1-git-send-email-weiyj_lk@163.com>
 <1467985621-13755-1-git-send-email-weiyj_lk@163.com>
Message-ID: <1468200685.32731.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-07-08 at 13:47 +0000, weiyj_lk at 163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fixes the following sparse warning:
> 
> sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:72:5: warning:
>  symbol 'mt2701_dai_num_to_i2s' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Garlic Tseng <garlic.tseng@mediatek.com>

> ---
>  sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
> index 15522c0..34a6123 100644
> --- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
> +++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
> @@ -69,7 +69,7 @@ static const struct mt2701_afe_rate mt2701_afe_i2s_rates[] = {
>  	{ .rate = 352800, .regvalue = 24 },
>  };
>  
> -int mt2701_dai_num_to_i2s(struct mtk_base_afe *afe, int num)
> +static int mt2701_dai_num_to_i2s(struct mtk_base_afe *afe, int num)
>  {
>  	int val = num - MT2701_IO_I2S;
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
