From: bhumirks@gmail.com (Bhumika Goyal)
Date: Sun, 12 Feb 2017 23:51:47 +0530
Subject: [PATCH] clocksource: add __ro_after_init to cyclecounter
In-Reply-To: <alpine.DEB.2.20.1702112129260.3734@nanos>
References: <1486840818-22214-1-git-send-email-bhumirks@gmail.com>
 <alpine.DEB.2.20.1702112129260.3734@nanos>
Message-ID: <CAOH+1jHa2NEQtuD65gUh0bAYYi_+H6rROK0CfttE0pA4p231JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 12, 2017 at 2:05 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Sun, 12 Feb 2017, Bhumika Goyal wrote:
>
> Please be more careful with your subject line. The prefix for this is
> definitely not 'clocksource'. git log would have told you the proper one:
>
> clocksource/drivers/arm_arch_timer
>
> 'clocksource' is the general subsystem and used for system wide changes or
> core changes, but not for a particular driver.
>

I will be more careful about this in future.

Thanks,
Bhumika

>> The object cyclecounter of type cyclecounter is not getting modified
>> after getting initialized by arch_counter_register. Apart from
>> initialization in arch_counter_register it is also passed as an argument
>> to the function timecounter_init but this argument is of type const.
>> Therefore, add __ro_after_init to its declaration.
>
> Other than that this is fine. I'll fix it up when applying.
>
> Thanks,
>
>         tglx
