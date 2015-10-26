From: lkp@intel.com (kbuild test robot)
Date: Tue, 27 Oct 2015 05:59:36 +0800
Subject: [PATCH 08/10] pwm: core: add pulse feature to the PWM framework
In-Reply-To: <1445895161-2317-9-git-send-email-o.schinagl@ultimaker.com>
Message-ID: <201510270544.8DKoIuoj%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olliver,

[auto build test ERROR on pwm/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Olliver-Schinagl/pwm-lpc18xx_pwm-use-pwm_set_chip_data/20151027-053853
config: x86_64-randconfig-n0-10270521 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/gpu/drm/i915/intel_panel.c: In function 'pwm_set_backlight':
>> drivers/gpu/drm/i915/intel_panel.c:652:2: error: too few arguments to function 'pwm_config'
     pwm_config(panel->backlight.pwm, duty_ns, CRC_PMIC_PWM_PERIOD_NS);
     ^
   In file included from drivers/gpu/drm/i915/intel_panel.c:35:0:
   include/linux/pwm.h:52:19: note: declared here
    static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
                      ^
   drivers/gpu/drm/i915/intel_panel.c: In function 'pwm_disable_backlight':
   drivers/gpu/drm/i915/intel_panel.c:797:2: error: too few arguments to function 'pwm_config'
     pwm_config(panel->backlight.pwm, 0, CRC_PMIC_PWM_PERIOD_NS);
     ^
   In file included from drivers/gpu/drm/i915/intel_panel.c:35:0:
   include/linux/pwm.h:52:19: note: declared here
    static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
                      ^
   drivers/gpu/drm/i915/intel_panel.c: In function 'pwm_setup_backlight':
   drivers/gpu/drm/i915/intel_panel.c:1442:11: error: too few arguments to function 'pwm_config'
     retval = pwm_config(panel->backlight.pwm, CRC_PMIC_PWM_PERIOD_NS,
              ^
   In file included from drivers/gpu/drm/i915/intel_panel.c:35:0:
   include/linux/pwm.h:52:19: note: declared here
    static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
                      ^

vim +/pwm_config +652 drivers/gpu/drm/i915/intel_panel.c

0fb890c0 Vandana Kannan 2015-05-05  646  
b029e66f Shobhit Kumar  2015-06-26  647  static void pwm_set_backlight(struct intel_connector *connector, u32 level)
b029e66f Shobhit Kumar  2015-06-26  648  {
b029e66f Shobhit Kumar  2015-06-26  649  	struct intel_panel *panel = &connector->panel;
b029e66f Shobhit Kumar  2015-06-26  650  	int duty_ns = DIV_ROUND_UP(level * CRC_PMIC_PWM_PERIOD_NS, 100);
b029e66f Shobhit Kumar  2015-06-26  651  
b029e66f Shobhit Kumar  2015-06-26 @652  	pwm_config(panel->backlight.pwm, duty_ns, CRC_PMIC_PWM_PERIOD_NS);
b029e66f Shobhit Kumar  2015-06-26  653  }
b029e66f Shobhit Kumar  2015-06-26  654  
7bd688cd Jani Nikula    2013-11-08  655  static void

:::::: The code at line 652 was first introduced by commit
:::::: b029e66fa8e39ba10dcc47b114be8da8b082493b drm/i915: Backlight control using CRC PMIC based PWM driver

:::::: TO: Shobhit Kumar <shobhit.kumar@intel.com>
:::::: CC: Daniel Vetter <daniel.vetter@ffwll.ch>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 27099 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151027/31573cfb/attachment-0001.obj>
