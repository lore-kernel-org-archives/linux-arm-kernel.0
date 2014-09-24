From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 23 Sep 2014 18:40:51 -0700
Subject: [PATCH v2 2/2] watchdog: dw_wdt: add restart handler support
In-Reply-To: <20140924091101.60e065cd@xhacker>
References: <1411458132-5410-1-git-send-email-jszhang@marvell.com>	<1411458132-5410-3-git-send-email-jszhang@marvell.com>	<20140923183159.GB24930@roeck-us.net>
 <20140924091101.60e065cd@xhacker>
Message-ID: <54222123.2050703@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2014 06:11 PM, Jisheng Zhang wrote:
[ ... ]
>>> +	dw_wdt.restart_handler.notifier_call = dw_wdt_restart_handle;
>>> +	dw_wdt.restart_handler.priority = 128;
>>> +	ret = register_restart_handler(&dw_wdt.restart_handler);
>>> +	if (ret)
>>> +		pr_warn("cannot register restart handler\n");
>>
>> Please use dev_warn(&pdev->dev, ...).
>
> Yep, that's what I thought when patching the code. But the original source is
> using pr_*(), so I use pr_warn() to keep unification. Is there any better
> solution?
>

Good point. Makes sense, then, to leave that as cleanup.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
