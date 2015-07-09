From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 9 Jul 2015 13:55:33 +0200
Subject: [RESEND PATCH-v2] rtc: 88pm80x: add device tree support
In-Reply-To: <1436424952-29680-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436424952-29680-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20150709115533.GY3127@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/07/2015 at 12:25:51 +0530, Vaibhav Hiremath wrote :
> Along with DT support, this patch also cleans up the unnecessary
> code around 'rtc_wakeup' initialization.
> 
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>

No need to resend, I'll take it. I'm current busy with other things and
it is still early in the development cycle.

> -	if (pm80x_pdata) {
> -		pdata = pm80x_pdata->rtc;
> -		if (pdata)
> -			info->rtc_dev->dev.platform_data = &pdata->rtc_wakeup;
> -	}
> +	/* remeber whether this power up is caused by PMIC RTC or not */

I'll fix that typo...

> +	info->rtc_dev->dev.platform_data = &pdata->rtc_wakeup;
>  

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
