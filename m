From: b.brezillon@overkiz.com (boris brezillon)
Date: Tue, 29 Oct 2013 14:25:38 +0100
Subject: [PATCH v5 0/4] watchdog: at91sam9_wdt: handle already configured
 wdt
In-Reply-To: <20131029125848.GB5261@spo001.leaseweb.com>
References: <1380871455-7324-1-git-send-email-b.brezillon@overkiz.com>
 <20131029075028.GF19704@spo001.leaseweb.com> <526F8E89.30005@overkiz.com>
 <20131029125848.GB5261@spo001.leaseweb.com>
Message-ID: <526FB752.7070708@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/10/2013 13:58, Wim Van Sebroeck wrote:
> Hi Boris,
>
>> I'm sorry for the inconvenience, but I found some bugs in my patch series:
>>
>> 1) the secs_to_ticks returns an erronous value when 0 is passed as an
>> argument
>> 2) the calculated heartbeat is too small for some use cases
>>      (i.e. kexecing a new kernel might trigger a watchdog reset before
>> the new kernel
>>       is able to load the watchdog driver)
>> 3) when initializing the watchdog driver, the timer should be configured
>> with the min_heartbeat value
>>      instead of the standard heartbeat value, because we don't for how
>> long the timer has been running.
>>
>> I'll send a new patch fixing those issues.
>> I hope it won't bother you :-(.
> No problem :-). Just sent me the fixes when they are ready.

Already done : https://lkml.org/lkml/2013/10/29/207.

Thanks.

Best Regards,

Boris

>
> Kind regards,
> Wim.
>
