From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Wed, 12 Jul 2017 19:20:17 +0200 (CEST)
Subject: [PATCH v2 11/22] rtc: gemini: stop using rtc deprecated functions
In-Reply-To: <1499846682-14093-12-git-send-email-benjamin.gaignard@linaro.org>
References: <1499846682-14093-1-git-send-email-benjamin.gaignard@linaro.org>
 <1499846682-14093-12-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <alpine.LNX.2.00.1707121915310.8002@T420s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin,

On Wed, 12 Jul 2017, Benjamin Gaignard wrote:

> @@ -93,12 +93,12 @@ static int ftrtc010_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct ftrtc010_rtc *rtc = dev_get_drvdata(dev);
>  	unsigned int sec, min, hour, day;
> -	unsigned long offset, time;
> +	unsigned long long offset, time;
>  
>  	if (tm->tm_year >= 2148)	/* EPOCH Year + 179 */
>  		return -EINVAL;
>  
> -	rtc_tm_to_time(tm, &time);
> +	time = rtc_tm_to_time64(tm);
>  
>  	sec = readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
>  	min = readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);

later on this will do

	writel(offset, rtc->rtc_base + FTRTC010_RTC_RECORD);

you are writing some 64bit value in a 32bit register ...

NACK here

Greetings from Cologne
Hans Ulli Kroll

> 1.9.1
> 
> 
