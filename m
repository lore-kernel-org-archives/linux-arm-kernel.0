From: lkp@intel.com (kbuild test robot)
Date: Thu, 8 Sep 2016 02:37:36 +0800
Subject: [PATCH 1/3] serial: mctrl_gpio: implement mctrl_gpio_use_rtscts
In-Reply-To: <20160907161324.27774-1-richard.genoud@gmail.com>
Message-ID: <201609080259.I6IbJUFg%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

[auto build test WARNING on abelloni/rtc-next]
[also build test WARNING on v4.8-rc5 next-20160907]
[cannot apply to tty/tty-testing]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Richard-Genoud/serial-mctrl_gpio-implement-mctrl_gpio_use_rtscts/20160908-002703
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
config: sh-titan_defconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All warnings (new ones prefixed by >>):

   In file included from drivers/tty/serial/sh-sci.c:60:0:
   drivers/tty/serial/serial_mctrl_gpio.h: In function 'mctrl_gpio_use_rtscts':
>> drivers/tty/serial/serial_mctrl_gpio.h:162:1: warning: no return statement in function returning non-void [-Wreturn-type]
    }
    ^

vim +162 drivers/tty/serial/serial_mctrl_gpio.h

   146	
   147	static inline
   148	void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios)
   149	{
   150	}
   151	
   152	static inline void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios)
   153	{
   154	}
   155	
   156	static inline void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
   157	{
   158	}
   159	
   160	static inline bool mctrl_gpio_use_rtscts(struct mctrl_gpios *gpios)
   161	{
 > 162	}
   163	
   164	#endif /* GPIOLIB */
   165	
   166	#endif

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 15819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/0ef0b669/attachment-0001.obj>
