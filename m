From: zhanzhenbo@gmail.com (Steve zhan)
Date: Mon, 14 Jan 2013 21:33:45 +0800
Subject: Question: ARM: local timers: add num_possible_cpus() in
 local_timer_register()
Message-ID: <20130114133345.GA26701@android11.spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

	Do you think we should add num_possible_cpus() in 
local_timer_register() function, When core number is 
> 1, then reutrn TRUE? Enable the local timer only if 
we have more than one CPU, if the current config is
SMP and setup_max_cpus >= 1, but if smp_init_cpus in 
platform code have set cpu possible value to One(that 
maybe read number from scu or other hardware), then 
percpu_timer_setup in smp_prepare_cpus have no chance
to be called.

	For local timer, because local_timer_register have
return 1, that will miss global timer register. 

	Could you pls check it?


Regards,
Steve.
