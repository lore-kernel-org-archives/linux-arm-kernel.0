From: lkp@intel.com (kbuild test robot)
Date: Sun, 25 Feb 2018 04:49:30 +0800
Subject: [PATCH v3 01/10] pwm: extend PWM framework with PWM modes
In-Reply-To: <1519300881-8136-2-git-send-email-claudiu.beznea@microchip.com>
References: <1519300881-8136-2-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <201802250410.reI8wAy2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Claudiu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pwm/for-next]
[also build test WARNING on v4.16-rc2 next-20180223]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Claudiu-Beznea/extend-PWM-framework-to-support-PWM-modes/20180225-024011
base:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git for-next
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All warnings (new ones prefixed by >>):

>> drivers//pwm/pwm-sun4i.c:36:0: warning: "PWM_MODE" redefined
    #define PWM_MODE  BIT(7)
    
   In file included from drivers//pwm/pwm-sun4i.c:19:0:
   include/linux/pwm.h:40:0: note: this is the location of the previous definition
    #define PWM_MODE(name)  BIT(PWM_MODE_##name##_BIT)
    

vim +/PWM_MODE +36 drivers//pwm/pwm-sun4i.c

09853ce7 Alexandre Belloni 2014-12-17  29  
09853ce7 Alexandre Belloni 2014-12-17  30  #define PWMCH_OFFSET		15
09853ce7 Alexandre Belloni 2014-12-17  31  #define PWM_PRESCAL_MASK	GENMASK(3, 0)
09853ce7 Alexandre Belloni 2014-12-17  32  #define PWM_PRESCAL_OFF		0
09853ce7 Alexandre Belloni 2014-12-17  33  #define PWM_EN			BIT(4)
09853ce7 Alexandre Belloni 2014-12-17  34  #define PWM_ACT_STATE		BIT(5)
09853ce7 Alexandre Belloni 2014-12-17  35  #define PWM_CLK_GATING		BIT(6)
09853ce7 Alexandre Belloni 2014-12-17 @36  #define PWM_MODE		BIT(7)
09853ce7 Alexandre Belloni 2014-12-17  37  #define PWM_PULSE		BIT(8)
09853ce7 Alexandre Belloni 2014-12-17  38  #define PWM_BYPASS		BIT(9)
09853ce7 Alexandre Belloni 2014-12-17  39  

:::::: The code at line 36 was first introduced by commit
:::::: 09853ce7bc1003a490c7ee74a5705d7a7cf16b7d pwm: Add Allwinner SoC support

:::::: TO: Alexandre Belloni <alexandre.belloni@free-electrons.com>
:::::: CC: Thierry Reding <thierry.reding@gmail.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 52627 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180225/a49faeb5/attachment-0001.gz>
