From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Oct 2016 17:39:15 +0100
Subject: [arm:for-next 7/8] warning: (ARM && ..) selects
 GENERIC_CLOCKEVENTS_BROADCAST which has unmet direct dependencies
 (GENERIC_CLOCKEVENTS)
In-Reply-To: <201610200017.9XQc5RQ5%fengguang.wu@intel.com>
References: <201610200017.9XQc5RQ5%fengguang.wu@intel.com>
Message-ID: <20161019163915.GT1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch dropped.

On Thu, Oct 20, 2016 at 12:35:22AM +0800, kbuild test robot wrote:
> tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git for-next
> head:   4f3ebefbc0ed334491f0b7f1f0154b14c47c0774
> commit: e085002c23dfb35705c630b975827a69ff9aceb6 [7/8] ARM: 8620/1: Kconfig: select GENERIC_CLOCKEVENTS_BROADCAST also on UP
> config: arm-ebsa110_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout e085002c23dfb35705c630b975827a69ff9aceb6
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All error/warnings (new ones prefixed by >>):
> 
> warning: (ARM && SOC_AM43XX && MIPS_CPS_CPUIDLE) selects GENERIC_CLOCKEVENTS_BROADCAST which has unmet direct dependencies (GENERIC_CLOCKEVENTS)
>    kernel/time/tick-broadcast.c: In function 'tick_broadcast_start_periodic':
> >> kernel/time/tick-broadcast.c:65:3: error: implicit declaration of function 'tick_setup_periodic' [-Werror=implicit-function-declaration]
>       tick_setup_periodic(bc, 1);
>       ^~~~~~~~~~~~~~~~~~~
>    kernel/time/tick-broadcast.c: In function 'tick_check_broadcast_device':
> >> kernel/time/tick-broadcast.c:74:13: error: dereferencing pointer to incomplete type 'struct clock_event_device'
>      if ((newdev->features & CLOCK_EVT_FEAT_DUMMY) ||
>                 ^~
> >> kernel/time/tick-broadcast.c:74:26: error: 'CLOCK_EVT_FEAT_DUMMY' undeclared (first use in this function)
>      if ((newdev->features & CLOCK_EVT_FEAT_DUMMY) ||
>                              ^~~~~~~~~~~~~~~~~~~~
>    kernel/time/tick-broadcast.c:74:26: note: each undeclared identifier is reported only once for each function it appears in
> >> kernel/time/tick-broadcast.c:75:26: error: 'CLOCK_EVT_FEAT_PERCPU' undeclared (first use in this function)
>          (newdev->features & CLOCK_EVT_FEAT_PERCPU) ||
>                              ^~~~~~~~~~~~~~~~~~~~~
> >> kernel/time/tick-broadcast.c:76:26: error: 'CLOCK_EVT_FEAT_C3STOP' undeclared (first use in this function)
>          (newdev->features & CLOCK_EVT_FEAT_C3STOP))
>                              ^~~~~~~~~~~~~~~~~~~~~
> >> kernel/time/tick-broadcast.c:80:27: error: 'CLOCK_EVT_FEAT_ONESHOT' undeclared (first use in this function)
>          !(newdev->features & CLOCK_EVT_FEAT_ONESHOT))
>                               ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/time/tick-broadcast.c: In function 'tick_install_broadcast_device':
> >> kernel/time/tick-broadcast.c:99:2: error: implicit declaration of function 'clockevents_exchange_device' [-Werror=implicit-function-declaration]
>      clockevents_exchange_device(cur, dev);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> kernel/time/tick-broadcast.c:101:24: error: 'clockevents_handle_noop' undeclared (first use in this function)
>       cur->event_handler = clockevents_handle_noop;
>                            ^~~~~~~~~~~~~~~~~~~~~~~
>    kernel/time/tick-broadcast.c:113:22: error: 'CLOCK_EVT_FEAT_ONESHOT' undeclared (first use in this function)
>      if (dev->features & CLOCK_EVT_FEAT_ONESHOT)
>                          ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/time/tick-broadcast.c: In function 'tick_broadcast_update_freq':
> >> kernel/time/tick-broadcast.c:131:9: error: implicit declaration of function '__clockevents_update_freq' [-Werror=implicit-function-declaration]
>       ret = __clockevents_update_freq(dev, freq);
>             ^~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/time/tick-broadcast.c: In function 'tick_device_setup_broadcast_func':
> >> kernel/time/tick-broadcast.c:146:20: error: 'tick_broadcast' undeclared (first use in this function)
>       dev->broadcast = tick_broadcast;
>                        ^~~~~~~~~~~~~~
>    kernel/time/tick-broadcast.c: In function 'tick_device_uses_broadcast':
> >> kernel/time/tick-broadcast.c:172:7: error: implicit declaration of function 'tick_device_is_functional' [-Werror=implicit-function-declaration]
>      if (!tick_device_is_functional(dev)) {
>           ^~~~~~~~~~~~~~~~~~~~~~~~~
> >> kernel/time/tick-broadcast.c:173:24: error: 'tick_handle_periodic' undeclared (first use in this function)
>       dev->event_handler = tick_handle_periodic;
>                            ^~~~~~~~~~~~~~~~~~~~
>    kernel/time/tick-broadcast.c:186:25: error: 'CLOCK_EVT_FEAT_C3STOP' undeclared (first use in this function)
>       if (!(dev->features & CLOCK_EVT_FEAT_C3STOP))
>                             ^~~~~~~~~~~~~~~~~~~~~
> >> kernel/time/tick-broadcast.c:219:5: error: implicit declaration of function 'clockevents_shutdown' [-Werror=implicit-function-declaration]
>         clockevents_shutdown(bc);
>         ^~~~~~~~~~~~~~~~~~~~
> >> kernel/time/tick-broadcast.c:228:31: error: 'CLOCK_EVT_FEAT_HRTIMER' undeclared (first use in this function)
>        if (bc && !(bc->features & CLOCK_EVT_FEAT_HRTIMER))
>                                   ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/time/tick-broadcast.c: In function 'tick_do_broadcast':
>    kernel/time/tick-broadcast.c:284:28: error: 'CLOCK_EVT_FEAT_HRTIMER' undeclared (first use in this function)
>       local = !(bc->features & CLOCK_EVT_FEAT_HRTIMER);
>                                ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/time/tick-broadcast.c: In function 'tick_handle_periodic_broadcast':
> >> kernel/time/tick-broadcast.c:321:6: error: implicit declaration of function 'clockevent_state_shutdown' [-Werror=implicit-function-declaration]
>      if (clockevent_state_shutdown(tick_broadcast_device.evtdev)) {
>          ^~~~~~~~~~~~~~~~~~~~~~~~~
> >> kernel/time/tick-broadcast.c:328:6: error: implicit declaration of function 'clockevent_state_oneshot' [-Werror=implicit-function-declaration]
>      if (clockevent_state_oneshot(dev)) {
>          ^~~~~~~~~~~~~~~~~~~~~~~~
>    In file included from include/linux/rcupdate.h:47:0,
>                     from include/linux/idr.h:18,
>                     from include/linux/kernfs.h:14,
>                     from include/linux/sysfs.h:15,
>                     from include/linux/kobject.h:21,
>                     from include/linux/device.h:17,
>                     from include/linux/node.h:17,
>                     from include/linux/cpu.h:16,
>                     from kernel/time/tick-broadcast.c:14:
> >> kernel/time/tick-broadcast.c:329:45: error: 'tick_period' undeclared (first use in this function)
>       ktime_t next = ktime_add(dev->next_event, tick_period);
>                                                 ^
>    include/linux/ktime.h:64:39: note: in definition of macro 'ktime_add'
>       ({ (ktime_t){ .tv64 = (lhs).tv64 + (rhs).tv64 }; })
>                                           ^~~
> >> kernel/time/tick-broadcast.c:331:3: error: implicit declaration of function 'clockevents_program_event' [-Werror=implicit-function-declaration]
>       clockevents_program_event(dev, next, true);
>       ^~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/time/tick-broadcast.c: In function 'tick_broadcast_control':
>    kernel/time/tick-broadcast.c:367:32: error: 'CLOCK_EVT_FEAT_C3STOP' undeclared (first use in this function)
>      if (!dev || !(dev->features & CLOCK_EVT_FEAT_C3STOP))
>                                    ^~~~~~~~~~~~~~~~~~~~~
>    kernel/time/tick-broadcast.c:392:31: error: 'CLOCK_EVT_FEAT_HRTIMER' undeclared (first use in this function)
>        if (bc && !(bc->features & CLOCK_EVT_FEAT_HRTIMER) &&
>                                   ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/time/tick-broadcast.c: In function 'tick_set_periodic_handler':
>    kernel/time/tick-broadcast.c:433:24: error: 'tick_handle_periodic' undeclared (first use in this function)
>       dev->event_handler = tick_handle_periodic;
>                            ^~~~~~~~~~~~~~~~~~~~
>    kernel/time/tick-broadcast.c: In function 'tick_resume_broadcast':
> >> kernel/time/tick-broadcast.c:502:3: error: implicit declaration of function 'clockevents_tick_resume' [-Werror=implicit-function-declaration]
>       clockevents_tick_resume(bc);
>       ^~~~~~~~~~~~~~~~~~~~~~~
>    kernel/time/tick-broadcast.c: In function '__tick_broadcast_oneshot_control':
>    kernel/time/tick-broadcast.c:988:29: error: 'CLOCK_EVT_FEAT_HRTIMER' undeclared (first use in this function)
>      if (!bc || (bc->features & CLOCK_EVT_FEAT_HRTIMER))
>                                 ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/time/tick-broadcast.c: In function 'tick_check_broadcast_device':
> >> kernel/time/tick-broadcast.c:84:1: warning: control reaches end of non-void function [-Wreturn-type]
>     }
>     ^
>    cc1: some warnings being treated as errors
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
