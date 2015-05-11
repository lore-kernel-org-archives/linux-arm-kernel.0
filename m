From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 11 May 2015 10:47:44 +0200
Subject: [PATCH 03/12] clocksource: sti: Provide 'use timer as sched clock'
 capability
In-Reply-To: <1431085625.13593.39.camel@x220>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>	
 <1431005924-21777-4-git-send-email-lee.jones@linaro.org>	
 <1431074699.13593.4.camel@x220> <20150508093603.GB29044@x1>	
 <1431078730.13593.14.camel@x220> <20150508102938.GD29044@x1>
 <1431085625.13593.39.camel@x220>
Message-ID: <55506CB0.2030909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2015 01:47 PM, Paul Bolle wrote:
> On Fri, 2015-05-08 at 11:29 +0100, Lee Jones wrote:
>> Ah, you mean from menuconfig.  I almost forgot what that was. ;)
>>
>> I can add a menu option, no problem.
>
> It's not just menuconfig:
>      $ grep -e CONFIG_ARCH_STI -e CONFIG_CLKSRC_ST_LPC .config
>      CONFIG_ARCH_STI=y
>      CONFIG_CLKSRC_ST_LPC=y
>      CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK=y
>      $ vim .config
>      $ grep -e CONFIG_ARCH_STI -e CONFIG_CLKSRC_ST_LPC .config
>      CONFIG_ARCH_STI=y
>      # CONFIG_CLKSRC_ST_LPC is not set
>      # CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK is not set
>      $ make ARCH=arm silentoldconfig
>      scripts/kconfig/conf  --silentoldconfig Kconfig
>      #
>      # configuration written to .config
>      #
>      $ grep -e CONFIG_ARCH_STI -e CONFIG_CLKSRC_ST_LPC .config
>      CONFIG_ARCH_STI=y
>      CONFIG_CLKSRC_ST_LPC=y
>      CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK=y
>
> So I think that, if you want to be able to set
> CLKSRC_ST_LPC_TIMER_SCHED_CLOCK to 'n' even though CLKSRC_ST_LPC is 'y',
> you need to add a prompt. Or have you found a way around this?

The general policy is to have non-prompted options in the clocksource's 
Kconfig and let the platform's config to select the right components.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
