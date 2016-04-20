From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 20 Apr 2016 13:59:12 +0200
Subject: [PATCH] ARM: mediatek: enable gpt6 on boot up to make arch timer
 work on mt7623
In-Reply-To: <1460053115-53448-1-git-send-email-blogic@openwrt.org>
References: <1460053115-53448-1-git-send-email-blogic@openwrt.org>
Message-ID: <57176F10.3010202@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/04/16 20:18, John Crispin wrote:
> GPT6 needs to be enabled on MT7623 for the arch timer to work.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>   arch/arm/mach-mediatek/mediatek.c |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-mediatek/mediatek.c b/arch/arm/mach-mediatek/mediatek.c
> index 9c2e38d..a6e3c98 100644
> --- a/arch/arm/mach-mediatek/mediatek.c
> +++ b/arch/arm/mach-mediatek/mediatek.c
> @@ -29,6 +29,7 @@ static void __init mediatek_timer_init(void)
>   	void __iomem *gpt_base;
>
>   	if (of_machine_is_compatible("mediatek,mt6589") ||
> +	    of_machine_is_compatible("mediatek,mt7623") ||
>   	    of_machine_is_compatible("mediatek,mt8135") ||
>   	    of_machine_is_compatible("mediatek,mt8127")) {
>   		/* turn on GPT6 which ungates arch timer clocks */
>

Applied thanks.
