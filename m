From: lkp@intel.com (kbuild test robot)
Date: Wed, 15 Jun 2016 23:51:29 +0800
Subject: [PATCH v3 1/2] clocksource: Add Oxford Semiconductor RPS Dual
 Timer
In-Reply-To: <1465985607-21231-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <201606152311.i4cc0bJ4%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on tip/timers/core]
[also build test ERROR on v4.7-rc3 next-20160615]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Neil-Armstrong/clocksource-Add-support-for-Oxford-Semiconductor-RPS-Dual-Timer/20160615-181650
config: ia64-allyesconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All error/warnings (new ones prefixed by >>):

>> drivers/clocksource/timer-oxnas-rps.c:62:28: error: field 'clkevent' has incomplete type
     struct clock_event_device clkevent;
                               ^
   In file included from include/linux/list.h:8:0,
                    from include/linux/smp.h:11,
                    from include/linux/irq.h:12,
                    from drivers/clocksource/timer-oxnas-rps.c:24:
   drivers/clocksource/timer-oxnas-rps.c: In function 'oxnas_rps_timer_shutdown':
   include/linux/kernel.h:831:48: warning: initialization from incompatible pointer type
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/clocksource/timer-oxnas-rps.c:101:3: note: in expansion of macro 'container_of'
      container_of(evt, struct oxnas_rps_timer, clkevent);
      ^
   include/linux/kernel.h:831:48: warning: (near initialization for 'rps')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/clocksource/timer-oxnas-rps.c:101:3: note: in expansion of macro 'container_of'
      container_of(evt, struct oxnas_rps_timer, clkevent);
      ^
   drivers/clocksource/timer-oxnas-rps.c: In function 'oxnas_rps_timer_set_periodic':
   include/linux/kernel.h:831:48: warning: initialization from incompatible pointer type
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-oxnas-rps.c:111:3: note: in expansion of macro 'container_of'
      container_of(evt, struct oxnas_rps_timer, clkevent);
      ^
   include/linux/kernel.h:831:48: warning: (near initialization for 'rps')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-oxnas-rps.c:111:3: note: in expansion of macro 'container_of'
      container_of(evt, struct oxnas_rps_timer, clkevent);
      ^
   drivers/clocksource/timer-oxnas-rps.c: In function 'oxnas_rps_timer_set_oneshot':
   include/linux/kernel.h:831:48: warning: initialization from incompatible pointer type
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-oxnas-rps.c:121:3: note: in expansion of macro 'container_of'
      container_of(evt, struct oxnas_rps_timer, clkevent);
      ^
   include/linux/kernel.h:831:48: warning: (near initialization for 'rps')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-oxnas-rps.c:121:3: note: in expansion of macro 'container_of'
      container_of(evt, struct oxnas_rps_timer, clkevent);
      ^
   drivers/clocksource/timer-oxnas-rps.c: In function 'oxnas_rps_timer_next_event':
   include/linux/kernel.h:831:48: warning: initialization from incompatible pointer type
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-oxnas-rps.c:132:3: note: in expansion of macro 'container_of'
      container_of(evt, struct oxnas_rps_timer, clkevent);
      ^
   include/linux/kernel.h:831:48: warning: (near initialization for 'rps')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-oxnas-rps.c:132:3: note: in expansion of macro 'container_of'
      container_of(evt, struct oxnas_rps_timer, clkevent);
      ^
   drivers/clocksource/timer-oxnas-rps.c: In function 'oxnas_rps_clockevent_init':
>> drivers/clocksource/timer-oxnas-rps.c:161:27: error: 'CLOCK_EVT_FEAT_PERIODIC' undeclared (first use in this function)
     rps->clkevent.features = CLOCK_EVT_FEAT_PERIODIC |
                              ^
   drivers/clocksource/timer-oxnas-rps.c:161:27: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/clocksource/timer-oxnas-rps.c:162:6: error: 'CLOCK_EVT_FEAT_ONESHOT' undeclared (first use in this function)
         CLOCK_EVT_FEAT_ONESHOT |
         ^
>> drivers/clocksource/timer-oxnas-rps.c:163:6: error: 'CLOCK_EVT_FEAT_DYNIRQ' undeclared (first use in this function)
         CLOCK_EVT_FEAT_DYNIRQ;
         ^
>> drivers/clocksource/timer-oxnas-rps.c:172:2: error: implicit declaration of function 'clockevents_config_and_register' [-Werror=implicit-function-declaration]
     clockevents_config_and_register(&rps->clkevent,
     ^
   drivers/clocksource/timer-oxnas-rps.c: In function 'oxnas_rps_clocksource_init':
>> drivers/clocksource/timer-oxnas-rps.c:209:2: error: implicit declaration of function 'clocksource_mmio_init' [-Werror=implicit-function-declaration]
     ret = clocksource_mmio_init(timer_sched_base,
     ^
>> drivers/clocksource/timer-oxnas-rps.c:212:9: error: 'clocksource_mmio_readl_down' undeclared (first use in this function)
            clocksource_mmio_readl_down);
            ^
   drivers/clocksource/timer-oxnas-rps.c: At top level:
>> drivers/clocksource/timer-oxnas-rps.c:290:10: error: expected ')' before string constant
             "oxsemi,ox810se-rps-timer", oxnas_rps_timer_init);
             ^
   drivers/clocksource/timer-oxnas-rps.c:223:20: warning: 'oxnas_rps_timer_init' defined but not used [-Wunused-function]
    static void __init oxnas_rps_timer_init(struct device_node *np)
                       ^
   cc1: some warnings being treated as errors

vim +/clkevent +62 drivers/clocksource/timer-oxnas-rps.c

    18	 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
    19	 */
    20	
    21	#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
    22	
    23	#include <linux/init.h>
  > 24	#include <linux/irq.h>
    25	#include <linux/io.h>
    26	#include <linux/clk.h>
    27	#include <linux/slab.h>
    28	#include <linux/interrupt.h>
    29	#include <linux/of_irq.h>
    30	#include <linux/of_address.h>
    31	#include <linux/clockchips.h>
    32	#include <linux/sched_clock.h>
    33	
    34	/* TIMER1 used as tick
    35	 * TIMER2 used as clocksource
    36	 */
    37	
    38	/* Registers definitions */
    39	
    40	#define TIMER_LOAD_REG		0x0
    41	#define TIMER_CURR_REG		0x4
    42	#define TIMER_CTRL_REG		0x8
    43	#define TIMER_CLRINT_REG	0xC
    44	
    45	#define TIMER_BITS		24
    46	
    47	#define TIMER_MAX_VAL		(BIT(TIMER_BITS) - 1)
    48	
    49	#define TIMER_PERIODIC		BIT(6)
    50	#define TIMER_ENABLE		BIT(7)
    51	
    52	#define TIMER_DIV1		(0)
    53	#define TIMER_DIV16		(1 << 2)
    54	#define TIMER_DIV256		(2 << 2)
    55	
    56	#define TIMER1_REG_OFFSET	0
    57	#define TIMER2_REG_OFFSET	0x20
    58	
    59	/* Clockevent & Clocksource data */
    60	
    61	struct oxnas_rps_timer {
  > 62		struct clock_event_device clkevent;
    63		void __iomem *clksrc_base;
    64		void __iomem *clkevt_base;
    65		unsigned long timer_period;
    66		unsigned int timer_prescaler;
    67		struct clk *clk;
    68		int irq;
    69	};
    70	
    71	static irqreturn_t oxnas_rps_timer_irq(int irq, void *dev_id)
    72	{
    73		struct oxnas_rps_timer *rps = dev_id;
    74	
    75		writel_relaxed(0, rps->clkevt_base + TIMER_CLRINT_REG);
    76	
    77		rps->clkevent.event_handler(&rps->clkevent);
    78	
    79		return IRQ_HANDLED;
    80	}
    81	
    82	static void oxnas_rps_timer_config(struct oxnas_rps_timer *rps,
    83					   unsigned long period,
    84					   unsigned int periodic)
    85	{
    86		uint32_t cfg = rps->timer_prescaler;
    87	
    88		if (period)
    89			cfg |= TIMER_ENABLE;
    90	
    91		if (periodic)
    92			cfg |= TIMER_PERIODIC;
    93	
    94		writel_relaxed(period, rps->clkevt_base + TIMER_LOAD_REG);
    95		writel_relaxed(cfg, rps->clkevt_base + TIMER_CTRL_REG);
    96	}
    97	
    98	static int oxnas_rps_timer_shutdown(struct clock_event_device *evt)
    99	{
   100		struct oxnas_rps_timer *rps =
 > 101			container_of(evt, struct oxnas_rps_timer, clkevent);
   102	
   103		oxnas_rps_timer_config(rps, 0, 0);
   104	
   105		return 0;
   106	}
   107	
   108	static int oxnas_rps_timer_set_periodic(struct clock_event_device *evt)
   109	{
   110		struct oxnas_rps_timer *rps =
   111			container_of(evt, struct oxnas_rps_timer, clkevent);
   112	
   113		oxnas_rps_timer_config(rps, rps->timer_period, 1);
   114	
   115		return 0;
   116	}
   117	
   118	static int oxnas_rps_timer_set_oneshot(struct clock_event_device *evt)
   119	{
   120		struct oxnas_rps_timer *rps =
   121			container_of(evt, struct oxnas_rps_timer, clkevent);
   122	
   123		oxnas_rps_timer_config(rps, rps->timer_period, 0);
   124	
   125		return 0;
   126	}
   127	
   128	static int oxnas_rps_timer_next_event(unsigned long delta,
   129					struct clock_event_device *evt)
   130	{
   131		struct oxnas_rps_timer *rps =
 > 132			container_of(evt, struct oxnas_rps_timer, clkevent);
   133	
   134		oxnas_rps_timer_config(rps, delta, 0);
   135	
   136		return 0;
   137	}
   138	
   139	static int __init oxnas_rps_clockevent_init(struct oxnas_rps_timer *rps)
   140	{
   141		ulong clk_rate = clk_get_rate(rps->clk);
   142		ulong timer_rate;
   143	
   144		/* Start with prescaler 1 */
   145		rps->timer_prescaler = TIMER_DIV1;
   146		rps->timer_period = DIV_ROUND_UP(clk_rate, HZ);
   147		timer_rate = clk_rate;
   148	
   149		if (rps->timer_period > TIMER_MAX_VAL) {
   150			rps->timer_prescaler = TIMER_DIV16;
   151			timer_rate = clk_rate / 16;
   152			rps->timer_period = DIV_ROUND_UP(timer_rate, HZ);
   153		}
   154		if (rps->timer_period > TIMER_MAX_VAL) {
   155			rps->timer_prescaler = TIMER_DIV256;
   156			timer_rate = clk_rate / 256;
   157			rps->timer_period = DIV_ROUND_UP(timer_rate, HZ);
   158		}
   159	
   160		rps->clkevent.name = "oxnas-rps";
 > 161		rps->clkevent.features = CLOCK_EVT_FEAT_PERIODIC |
 > 162					 CLOCK_EVT_FEAT_ONESHOT |
 > 163					 CLOCK_EVT_FEAT_DYNIRQ;
   164		rps->clkevent.tick_resume = oxnas_rps_timer_shutdown;
   165		rps->clkevent.set_state_shutdown = oxnas_rps_timer_shutdown;
   166		rps->clkevent.set_state_periodic = oxnas_rps_timer_set_periodic;
   167		rps->clkevent.set_state_oneshot = oxnas_rps_timer_set_oneshot;
   168		rps->clkevent.set_next_event = oxnas_rps_timer_next_event;
   169		rps->clkevent.rating = 200;
   170		rps->clkevent.cpumask = cpu_possible_mask;
   171		rps->clkevent.irq = rps->irq;
 > 172		clockevents_config_and_register(&rps->clkevent,
   173						timer_rate,
   174						1,
   175						TIMER_MAX_VAL);
   176	
   177		pr_info("Registered clock event rate %luHz prescaler %x period %lu\n",
   178				clk_rate,
   179				rps->timer_prescaler,
   180				rps->timer_period);
   181	
   182		return 0;
   183	}
   184	
   185	/* Clocksource */
   186	
   187	static void __iomem *timer_sched_base;
   188	
   189	static u64 notrace oxnas_rps_read_sched_clock(void)
   190	{
   191		return ~readl_relaxed(timer_sched_base);
   192	}
   193	
   194	static int __init oxnas_rps_clocksource_init(struct oxnas_rps_timer *rps)
   195	{
   196		ulong clk_rate = clk_get_rate(rps->clk);
   197		int ret;
   198	
   199		/* use prescale 16 */
   200		clk_rate = clk_rate / 16;
   201	
   202		writel_relaxed(TIMER_MAX_VAL, rps->clksrc_base + TIMER_LOAD_REG);
   203		writel_relaxed(TIMER_PERIODIC | TIMER_ENABLE | TIMER_DIV16,
   204				rps->clksrc_base + TIMER_CTRL_REG);
   205	
   206		timer_sched_base = rps->clksrc_base + TIMER_CURR_REG;
   207		sched_clock_register(oxnas_rps_read_sched_clock,
   208				     TIMER_BITS, clk_rate);
 > 209		ret = clocksource_mmio_init(timer_sched_base,
   210					    "oxnas_rps_clocksource_timer",
   211					    clk_rate, 250, TIMER_BITS,
 > 212					    clocksource_mmio_readl_down);
   213		if (WARN_ON(ret)) {
   214			pr_err("can't register clocksource\n");
   215			return ret;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 46357 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160615/e4fbf8f0/attachment-0001.obj>
