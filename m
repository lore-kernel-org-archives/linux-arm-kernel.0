From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 05 Feb 2010 13:35:52 +0300
Subject: [PATCH] input: schedule corgi_ssp and corgi_ts to be removed
In-Reply-To: <f17812d71002041645n15e502a3sccc76fc3f2e75c76@mail.gmail.com>
References: <f17812d71002041645n15e502a3sccc76fc3f2e75c76@mail.gmail.com>
Message-ID: <4B6BF488.3070107@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Eric Miao wrote:

> commit 31cec413e534520111716802833675f53ac99b0b
> Author: Eric Miao <eric.y.miao@gmail.com>
> Date:   Thu Feb 4 16:41:28 2010 -0800
>
>     input: schedule corgi_ssp and corgi_ts to be removed
>
>     Cc: Richard Purdie <rpurdie@rpsys.net>
>     Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
>   

   Some grammar nitpicking...

> diff --git a/Documentation/feature-removal-schedule.txt
> b/Documentation/feature-removal-schedule.txt
> index 5860583..e16529e 100644
> --- a/Documentation/feature-removal-schedule.txt
> +++ b/Documentation/feature-removal-schedule.txt
> @@ -554,3 +554,15 @@ Why:	We now have a generic GPIO based matrix
> keyboard driver that
>  	and so are difficult to maintain.
>  Who:	Eric Miao <eric.y.miao@gmail.com>
>
> +----------------------------
> +
> +What:	corgi_ssp and corgi_ts driver
> +When:	2.6.35
> +Files:	arch/arm/mach-pxa/corgi_ssp.c, drivers/input/touchscreen/corgi_ts.c
> +Why:	The corgi touchscreen is now deprecated in favour of the generic
> +	ads7846.c driver. The noise reduction technique used in corgi_ts.c
> +	that to wait til vsync before ADC sampling is also

   that's?


>  inte grated into
>   

    integrated.

> +	ads7846 driver now. Provided that the original driver is no generic
>   

   not generic

> +	and difficult to maintain, will be removed later.
>   

   it will.

> +Who:	Eric Miao <eric.y.miao@gmail.com>
> +
>   

WBR, Sergei
