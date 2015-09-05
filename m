From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sat, 5 Sep 2015 11:53:08 -0700
Subject: [PATCH v3 1/5] input: touchscreen: add imx6ul_tsc driver support
In-Reply-To: <1440752976-9094-2-git-send-email-haibo.chen@freescale.com>
References: <1440752976-9094-1-git-send-email-haibo.chen@freescale.com>
 <1440752976-9094-2-git-send-email-haibo.chen@freescale.com>
Message-ID: <20150905185308.GC18006@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 28, 2015 at 05:09:32PM +0800, Haibo Chen wrote:
> Freescale i.MX6UL contains a internal touchscreen controller,
> this patch add a driver to support this controller.
> 
> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>

Merged #1 and #2 and applied, thank you.

Also:

> +		/*
> +		 * Delay some time(max 2ms), wait the pre-charge done.
> +		 * After the pre-change mode, TSC go into detect mode.
> +		 * And in detect mode, we can get the xnur gpio value.
> +		 * If xnur is high, this means the touch screen still
> +		 * be touched. If xnur is low, this means finger leave
> +		 * the touch screen.
> +		 */
> +		timeout = jiffies + HZ/500;

I do not think that would quite work with HZ < 500. I changed this to

		timeout = jiffies + msecs_to_jiffies(2);

and also moved this block into a separate function.

Thanks.

-- 
Dmitry
