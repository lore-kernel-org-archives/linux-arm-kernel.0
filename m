From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Thu, 21 Jun 2018 19:59:39 +0200
Subject: [PATCH 1/2] rtc: armada38x: drop redundant initialization
In-Reply-To: <00ffe926e6878724d8289dd0e289a1f16df55ef7.1529602823.git.baruch@tkos.co.il>
References: <00ffe926e6878724d8289dd0e289a1f16df55ef7.1529602823.git.baruch@tkos.co.il>
Message-ID: <20180621175939.GL7737@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/06/2018 20:40:22+0300, Baruch Siach wrote:
> The 'ret' variable in these functions is set unconditionally below.
> 

Hum, what is the actual benefit of this patch?

> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/rtc/rtc-armada38x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
> index 1e4978c96ffd..4d62a54fd5d6 100644
> --- a/drivers/rtc/rtc-armada38x.c
> +++ b/drivers/rtc/rtc-armada38x.c
> @@ -229,7 +229,7 @@ static int armada38x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  static int armada38x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
> -	int ret = 0;
> +	int ret;
>  	unsigned long time, flags;
>  
>  	ret = rtc_tm_to_time(tm, &time);
> @@ -272,7 +272,7 @@ static int armada38x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	u32 reg = ALARM_REG(RTC_ALARM1, rtc->data->alarm);
>  	u32 reg_irq = ALARM_REG(RTC_IRQ1_CONF, rtc->data->alarm);
>  	unsigned long time, flags;
> -	int ret = 0;
> +	int ret;
>  
>  	ret = rtc_tm_to_time(&alrm->time, &time);
>  
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
