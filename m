From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Mon, 18 Feb 2013 05:27:38 +0000
Subject: [PATCH v4 3/8] watchdog/at91sam9_wdt: Convert to use the
 watchdog framework
In-Reply-To: <20130213231007.GE7867@spo001.leaseweb.com>
References: <1359702386-21284-1-git-send-email-wenyou.yang@atmel.com>
 <1359702386-21284-4-git-send-email-wenyou.yang@atmel.com>
 <20130213231007.GE7867@spo001.leaseweb.com>
Message-ID: <B256D81BAE5131468A838E5D7A24364145F0DD11@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wim,

> This code not only converts the watchdog to the new framework,
> but it also adds the is_enable related code changes which should
> be a seperate patch.
> 
> So I took your original patch and changed it to the below at91sam9_wdt
> watchdog conversion patch. Note: this is also without Fabio's timeout-sec
> patch, this one needs to come after the conversion.
> 
> Please test this patch and let me know if this works (the watchdog should
> behave the same before as after this patch).

Sorry for so late reply due to Chinese New Year's holiday.

I applied it on the linux-watchdog trees, 
and tested it on at91sam9m10g45ek both DT and non-DT support, at91sam9g25ek with DT support.

It works OK after one compilation error fixed.

> +	at91wdt_private.next_heartbeat = jiffies + wdd->timeout * HZ;
 +  at91wdt_private.next_heartbeat = jiffies + at91_wdt_dev.timeout * HZ;

Thank you very much.

Best Regards,
Wenyou Yang
