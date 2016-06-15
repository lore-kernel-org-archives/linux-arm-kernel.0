From: lkp@intel.com (kbuild test robot)
Date: Wed, 15 Jun 2016 23:35:42 +0800
Subject: [PATCH v3 1/2] clocksource: Add Oxford Semiconductor RPS Dual
 Timer
In-Reply-To: <1465985607-21231-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <201606152333.eO0VmlRI%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on tip/timers/core]
[also build test WARNING on v4.7-rc3 next-20160615]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Neil-Armstrong/clocksource-Add-support-for-Oxford-Semiconductor-RPS-Dual-Timer/20160615-181650
config: blackfin-allmodconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 4.6.3
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All warnings (new ones prefixed by >>):

>> drivers/clocksource/timer-oxnas-rps.c:50:0: warning: "TIMER_ENABLE" redefined [enabled by default]
   arch/blackfin/mach-bf533/include/mach/defBF532.h:97:0: note: this is the location of the previous definition

vim +/TIMER_ENABLE +50 drivers/clocksource/timer-oxnas-rps.c

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
  > 50	#define TIMER_ENABLE		BIT(7)
    51	
    52	#define TIMER_DIV1		(0)
    53	#define TIMER_DIV16		(1 << 2)
    54	#define TIMER_DIV256		(2 << 2)
    55	
    56	#define TIMER1_REG_OFFSET	0
    57	#define TIMER2_REG_OFFSET	0x20
    58	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 40631 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160615/ae9ac5bb/attachment-0001.obj>
