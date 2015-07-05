From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 04 Jul 2015 19:36:40 -0700
Subject: [PATCH v2 1/2] watchdog: NXP LPC18xx Watchdog Timer Driver
In-Reply-To: <5598911B.5020004@vanguardiasur.com.ar>
References: <1435783930-20184-1-git-send-email-ariel@vanguardiasur.com.ar>	<1435783930-20184-2-git-send-email-ariel@vanguardiasur.com.ar>
 <CAGhQ9VzLX_hy2Z=jUH6on0_sOZBp_mg5cC0JXkHntWxxrr2K6A@mail.gmail.com>
 <5598911B.5020004@vanguardiasur.com.ar>
Message-ID: <55989838.3030003@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/2015 07:06 PM, Ariel D'Alessandro wrote:
> Hi Joachim,
>
[ ... ]
>>> +
>>> +static int lpc18xx_wdt_start(struct watchdog_device *wdt_dev)
>>> +{
>>> +       struct lpc18xx_wdt_dev *lpc18xx_wdt = watchdog_get_drvdata(wdt_dev);
>>> +       unsigned int val;
>>> +
>>> +       if (timer_pending(&lpc18xx_wdt->timer))
>>> +               del_timer(&lpc18xx_wdt->timer);
>>> +
>>> +       val = readl(lpc18xx_wdt->base + LPC18XX_WDT_MOD);
>>> +       val |= LPC18XX_WDT_MOD_WDEN;
>>> +       val |= LPC18XX_WDT_MOD_WDRESET;
>>> +       writel(val, lpc18xx_wdt->base + LPC18XX_WDT_MOD);
>>
>> R-M-W sequence should probably be protect with a lock.
>
> We can continue discussing this point on Ezequiel's response.
>

Please avoid unnecessary locks.

Thanks,
Guenter
