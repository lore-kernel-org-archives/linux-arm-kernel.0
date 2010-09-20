From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 20 Sep 2010 22:47:08 +0800
Subject: [PATCH 10/11] ARM: pxa: Pass GPIO offset to ucb1400-gpio on PalmTC
In-Reply-To: <1284604382-23683-10-git-send-email-marek.vasut@gmail.com>
References: <1284604382-23683-1-git-send-email-marek.vasut@gmail.com>
	<1284604382-23683-10-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTi=_=r7ukGDL0oaB9Pw8n95fq3Ljp44VmuwoMz_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 16, 2010 at 10:33 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
> ?arch/arm/mach-pxa/palmtc.c | ? 10 +++++++++-
> ?1 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
> index 7f868d4..9c74ce9 100644
> --- a/arch/arm/mach-pxa/palmtc.c
> +++ b/arch/arm/mach-pxa/palmtc.c
> @@ -367,6 +367,14 @@ static inline void palmtc_udc_init(void) {}
> ?******************************************************************************/
> ?#if ? ?defined(CONFIG_TOUCHSCREEN_UCB1400) || \
> ? ? ? ?defined(CONFIG_TOUCHSCREEN_UCB1400_MODULE)
> +static struct ucb1400_pdata palmtc_ucb1400_pdata = {
> + ? ? ? .gpio_offset ? ?= PALMTC_UCB1400_GPIO_OFFSET,
> +};
> +
> +static pxa2xx_audio_ops_t palmtc_ac97_pdata = {
> + ? ? ? .codec_pdata ? ?= { &palmtc_ucb1400_pdata, },
> +};
> +
> ?static struct platform_device palmtc_ucb1400_device = {
> ? ? ? ?.name ? = "ucb1400_core",
> ? ? ? ?.id ? ? = -1,
> @@ -374,7 +382,7 @@ static struct platform_device palmtc_ucb1400_device = {
>
> ?static void __init palmtc_ts_init(void)
> ?{
> - ? ? ? pxa_set_ac97_info(NULL);
> + ? ? ? pxa_set_ac97_info(&palmtc_ac97_pdata);
> ? ? ? ?platform_device_register(&palmtc_ucb1400_device);
> ?}
> ?#else
> --
> 1.7.1
>
>

OK.
