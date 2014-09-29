From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 29 Sep 2014 19:48:45 +0200
Subject: [PATCH v1 2/4] arm: pxa: move init functions into generic.h
In-Reply-To: <3547658.YqqGlbv966@wuerfel> (Arnd Bergmann's message of "Mon, 29
 Sep 2014 18:08:39 +0200")
References: <1411973508-14301-1-git-send-email-robert.jarzmik@free.fr>
 <1411973508-14301-2-git-send-email-robert.jarzmik@free.fr>
 <3547658.YqqGlbv966@wuerfel>
Message-ID: <87y4t2b9mq.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Monday 29 September 2014 08:51:46 Robert Jarzmik wrote:
>> 
>>  #ifdef CONFIG_PXA25x
>> +#define pxa25x_handle_irq icip_handle_irq
>>  extern unsigned pxa25x_get_clk_frequency_khz(int);
>> +extern void __init pxa25x_init_irq(void);
>> +extern void __init pxa25x_map_io(void);
>> +#ifdef CONFIG_CPU_PXA26x
>> +extern void __init pxa26x_init_irq(void);
>> +#endif
>>  #else
>>  #define pxa25x_get_clk_frequency_khz(x)                (0)
>>  #endif
>> 
>
> It's better to add the declarations outside of the #ifdef. I believe
> the existing #ifdef is meant to provide a dummy alternative, but you
> don't actually want that for the other declarations, so just add them
> to a globally visible location.
OK for v2.

I will also put a note on my todo list to kill them. Their remaining purpose is
to provide frequency read accessor for get_clk_frequency(). Once the clock
framework will be done for all PXAs, get_clk_frequency() will become a simple
clk_get_rate(), or even better will be removed if I manage to transform viper.c
and the cpu frequency driver.

Cheers.

-- 
Robert
