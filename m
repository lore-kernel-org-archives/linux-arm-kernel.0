From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Jan 2013 13:35:44 +0000
Subject: Question: ARM: local timers: add num_possible_cpus() in
 local_timer_register()
In-Reply-To: <20130114133345.GA26701@android11.spreadtrum.com>
References: <20130114133345.GA26701@android11.spreadtrum.com>
Message-ID: <20130114133543.GD23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 09:33:45PM +0800, Steve zhan wrote:
> Hi Marc,
> 
> 	Do you think we should add num_possible_cpus() in 
> local_timer_register() function, When core number is 
> > 1, then reutrn TRUE? Enable the local timer only if 
> we have more than one CPU, if the current config is
> SMP and setup_max_cpus >= 1, but if smp_init_cpus in 
> platform code have set cpu possible value to One(that 
> maybe read number from scu or other hardware), then 
> percpu_timer_setup in smp_prepare_cpus have no chance
> to be called.
> 
> 	For local timer, because local_timer_register have
> return 1, that will miss global timer register. 

What about platforms where all they have are the local timers and no
global timer?
