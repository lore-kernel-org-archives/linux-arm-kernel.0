From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 16 Jun 2016 15:33:23 +0200
Subject: [PATCH v3 1/2] clocksource: Add Oxford Semiconductor RPS Dual
 Timer
In-Reply-To: <201606152333.eO0VmlRI%fengguang.wu@intel.com>
References: <201606152333.eO0VmlRI%fengguang.wu@intel.com>
Message-ID: <5762AAA3.8090304@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/2016 05:35 PM, kbuild test robot wrote:
> Hi,
>
> [auto build test WARNING on tip/timers/core]
> [also build test WARNING on v4.7-rc3 next-20160615]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Neil-Armstrong/clocksource-Add-support-for-Oxford-Semiconductor-RPS-Dual-Timer/20160615-181650
> config: blackfin-allmodconfig (attached as .config)
> compiler: bfin-uclinux-gcc (GCC) 4.6.3
> reproduce:
>          wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=blackfin
>
> All warnings (new ones prefixed by >>):
>
>>> drivers/clocksource/timer-oxnas-rps.c:50:0: warning: "TIMER_ENABLE" redefined [enabled by default]
>     arch/blackfin/mach-bf533/include/mach/defBF532.h:97:0: note: this is the location of the previous definition
>
> vim +/TIMER_ENABLE +50 drivers/clocksource/timer-oxnas-rps.c
>
>      34	/* TIMER1 used as tick
>      35	 * TIMER2 used as clocksource
>      36	 */
>      37	
>      38	/* Registers definitions */
>      39	
>      40	#define TIMER_LOAD_REG		0x0
>      41	#define TIMER_CURR_REG		0x4
>      42	#define TIMER_CTRL_REG		0x8
>      43	#define TIMER_CLRINT_REG	0xC
>      44	
>      45	#define TIMER_BITS		24
>      46	
>      47	#define TIMER_MAX_VAL		(BIT(TIMER_BITS) - 1)
>      48	
>      49	#define TIMER_PERIODIC		BIT(6)
>    > 50	#define TIMER_ENABLE		BIT(7)

It is already defined in the arch/blackfin/include dir.





-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
