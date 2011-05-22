From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 22 May 2011 16:42:30 +0400
Subject: spitz pm: adjust messages
In-Reply-To: <20110521122450.GA6954@elf.ucw.cz>
References: <20110521122450.GA6954@elf.ucw.cz>
Message-ID: <4DD904B6.4010700@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 21-05-2011 16:24, Pavel Machek wrote:

> Charger error is something that should be reported to the syslog; do
> it. If temperature reading fails, we do not want to charge the
> battery, anyway.

> Signed-off-by: Pavel Machek <pavel@ucw.cz>

> diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
> index 785880f..513588c 100644
> --- a/arch/arm/mach-pxa/sharpsl_pm.c
> +++ b/arch/arm/mach-pxa/sharpsl_pm.c
[...]
> @@ -513,8 +500,10 @@ static int sharpsl_check_battery_temp(void)
>   	val = get_select_val(buff);
>
>   	dev_dbg(sharpsl_pm.dev, "Temperature: %d\n", val);
> -	if (val>  sharpsl_pm.machinfo->charge_on_temp) {
> -		printk(KERN_WARNING "Not charging: temperature out of limits.\n");
> +	/* FIXME: this should catch battery read errors, but we should
> +	   probably avoid charging in<0C temperatures, too. */

    The preferred style of the multi-line comments is this:

/*
  * bla
  * bla
  */

WBR, Sergei
