From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 21 Aug 2009 15:34:29 -0700
Subject: [PATCH] watchdog: Add support for the Avionic Design Xanthos
	watchdog timer.
In-Reply-To: <1250860202-28187-1-git-send-email-thierry.reding@avionic-design.de>
References: <20090821073105.GC29382@infomag.iguana.be>
	<1250860202-28187-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20090821153429.2075e42d.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Aug 2009 15:10:02 +0200
Thierry Reding <thierry.reding@avionic-design.de> wrote:

> This patch adds support for the watchdog timer on Avionic Design Xanthos
> boards.
> 
>
> ...
>
> +static struct watchdog_info adx_wdt_info = {
> +	.identity = "Avionic Design Xanthos Watchdog",

heh, that fits with zero bytes to spare.

>
> ...
>
> +static const struct file_operations adx_wdt_fops = {
> +	.owner = THIS_MODULE,
> +	.llseek = no_llseek,
> +	.open = adx_wdt_open,
> +	.release = adx_wdt_release,
> +	.ioctl = adx_wdt_ioctl,

Nope.  All other watchdog drivers use .unlocked_ioctl and this one
should as well, please.

> +	.write = adx_wdt_write,
> +};
