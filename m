From: lkp@intel.com (kbuild test robot)
Date: Thu, 6 Jul 2017 14:13:25 +0800
Subject: [PATCH] gpio: drop unnecessary includes from
 include/linux/gpio/driver.h
In-Reply-To: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <201707061435.WWIUgm1i%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,

[auto build test ERROR on next-20170705]
[cannot apply to gpio/for-next tegra/for-next xlnx/master v4.12 v4.12-rc7 v4.12-rc6 v4.12]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/gpio-drop-unnecessary-includes-from-include-linux-gpio-driver-h/20170706-123711
config: blackfin-allyesconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All error/warnings (new ones prefixed by >>):

   drivers//i2c/muxes/i2c-mux-ltc4306.c: In function 'ltc4306_gpio_set_config':
>> drivers//i2c/muxes/i2c-mux-ltc4306.c:138:10: error: implicit declaration of function 'pinconf_to_config_param' [-Werror=implicit-function-declaration]
     switch (pinconf_to_config_param(config)) {
             ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers//i2c/muxes/i2c-mux-ltc4306.c:139:7: error: 'PIN_CONFIG_DRIVE_OPEN_DRAIN' undeclared (first use in this function)
     case PIN_CONFIG_DRIVE_OPEN_DRAIN:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers//i2c/muxes/i2c-mux-ltc4306.c:139:7: note: each undeclared identifier is reported only once for each function it appears in
>> drivers//i2c/muxes/i2c-mux-ltc4306.c:142:7: error: 'PIN_CONFIG_DRIVE_PUSH_PULL' undeclared (first use in this function)
     case PIN_CONFIG_DRIVE_PUSH_PULL:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers//staging/greybus/gpio.c: In function 'gb_gpio_set_config':
>> drivers//staging/greybus/gpio.c:483:6: error: implicit declaration of function 'pinconf_to_config_param' [-Werror=implicit-function-declaration]
     if (pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
         ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers//staging/greybus/gpio.c:483:41: error: 'PIN_CONFIG_INPUT_DEBOUNCE' undeclared (first use in this function)
     if (pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
                                            ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers//staging/greybus/gpio.c:483:41: note: each undeclared identifier is reported only once for each function it appears in
>> drivers//staging/greybus/gpio.c:486:13: error: implicit declaration of function 'pinconf_to_config_argument' [-Werror=implicit-function-declaration]
     debounce = pinconf_to_config_argument(config);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/usb/serial/cp210x.c: In function 'cp210x_gpio_set_config':
>> drivers/usb/serial/cp210x.c:1340:7: error: variable 'param' has initializer but incomplete type
     enum pin_config_param param = pinconf_to_config_param(config);
          ^~~~~~~~~~~~~~~~
>> drivers/usb/serial/cp210x.c:1340:32: error: implicit declaration of function 'pinconf_to_config_param' [-Werror=implicit-function-declaration]
     enum pin_config_param param = pinconf_to_config_param(config);
                                   ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/serial/cp210x.c:1340:24: error: storage size of 'param' isn't known
     enum pin_config_param param = pinconf_to_config_param(config);
                           ^~~~~
>> drivers/usb/serial/cp210x.c:1343:16: error: 'PIN_CONFIG_DRIVE_PUSH_PULL' undeclared (first use in this function)
     if ((param == PIN_CONFIG_DRIVE_PUSH_PULL) &&
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/serial/cp210x.c:1343:16: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/usb/serial/cp210x.c:1347:16: error: 'PIN_CONFIG_DRIVE_OPEN_DRAIN' undeclared (first use in this function)
     if ((param == PIN_CONFIG_DRIVE_OPEN_DRAIN) &&
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/serial/cp210x.c:1340:24: warning: unused variable 'param' [-Wunused-variable]
     enum pin_config_param param = pinconf_to_config_param(config);
                           ^~~~~
   cc1: some warnings being treated as errors
--
   drivers/hid/hid-cp2112.c: In function 'cp2112_gpio_irq_mask':
>> drivers/hid/hid-cp2112.c:1065:25: error: implicit declaration of function 'irq_data_get_irq_chip_data' [-Werror=implicit-function-declaration]
     struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hid/hid-cp2112.c:1065:25: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
>> drivers/hid/hid-cp2112.c:1068:15: error: dereferencing pointer to incomplete type 'struct irq_data'
     __clear_bit(d->hwirq, &dev->irq_mask);
                  ^~
   drivers/hid/hid-cp2112.c: In function 'cp2112_gpio_irq_unmask':
   drivers/hid/hid-cp2112.c:1073:25: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-cp2112.c: In function 'cp2112_gpio_poll_callback':
>> drivers/hid/hid-cp2112.c:1106:7: error: implicit declaration of function 'irq_get_irq_data' [-Werror=implicit-function-declaration]
      d = irq_get_irq_data(irq);
          ^~~~~~~~~~~~~~~~
>> drivers/hid/hid-cp2112.c:1106:5: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      d = irq_get_irq_data(irq);
        ^
>> drivers/hid/hid-cp2112.c:1110:14: error: implicit declaration of function 'irqd_get_trigger_type' [-Werror=implicit-function-declaration]
      irq_type = irqd_get_trigger_type(d);
                 ^~~~~~~~~~~~~~~~~~~~~
>> drivers/hid/hid-cp2112.c:1115:19: error: 'IRQ_TYPE_LEVEL_HIGH' undeclared (first use in this function)
       if (irq_type & IRQ_TYPE_LEVEL_HIGH)
                      ^~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-cp2112.c:1115:19: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/hid/hid-cp2112.c:1116:5: error: implicit declaration of function 'handle_nested_irq' [-Werror=implicit-function-declaration]
        handle_nested_irq(irq);
        ^~~~~~~~~~~~~~~~~
>> drivers/hid/hid-cp2112.c:1118:20: error: 'IRQ_TYPE_EDGE_RISING' undeclared (first use in this function)
       if ((irq_type & IRQ_TYPE_EDGE_RISING) &&
                       ^~~~~~~~~~~~~~~~~~~~
>> drivers/hid/hid-cp2112.c:1124:19: error: 'IRQ_TYPE_LEVEL_LOW' undeclared (first use in this function)
       if (irq_type & IRQ_TYPE_LEVEL_LOW)
                      ^~~~~~~~~~~~~~~~~~
>> drivers/hid/hid-cp2112.c:1127:20: error: 'IRQ_TYPE_EDGE_FALLING' undeclared (first use in this function)
       if ((irq_type & IRQ_TYPE_EDGE_FALLING) &&
                       ^~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-cp2112.c: In function 'cp2112_gpio_irq_startup':
   drivers/hid/hid-cp2112.c:1143:25: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-cp2112.c: In function 'cp2112_gpio_irq_shutdown':
   drivers/hid/hid-cp2112.c:1161:25: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-cp2112.c: At top level:
>> drivers/hid/hid-cp2112.c:1172:15: error: variable 'cp2112_gpio_irqchip' has initializer but incomplete type
    static struct irq_chip cp2112_gpio_irqchip = {
                  ^~~~~~~~
>> drivers/hid/hid-cp2112.c:1173:2: error: unknown field 'name' specified in initializer
     .name = "cp2112-gpio",
     ^
>> drivers/hid/hid-cp2112.c:1173:10: warning: excess elements in struct initializer
     .name = "cp2112-gpio",
             ^~~~~~~~~~~~~
   drivers/hid/hid-cp2112.c:1173:10: note: (near initialization for 'cp2112_gpio_irqchip')
>> drivers/hid/hid-cp2112.c:1174:2: error: unknown field 'irq_startup' specified in initializer
     .irq_startup = cp2112_gpio_irq_startup,
     ^
   drivers/hid/hid-cp2112.c:1174:17: warning: excess elements in struct initializer
     .irq_startup = cp2112_gpio_irq_startup,
                    ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-cp2112.c:1174:17: note: (near initialization for 'cp2112_gpio_irqchip')
>> drivers/hid/hid-cp2112.c:1175:2: error: unknown field 'irq_shutdown' specified in initializer
     .irq_shutdown = cp2112_gpio_irq_shutdown,
     ^
   drivers/hid/hid-cp2112.c:1175:18: warning: excess elements in struct initializer
     .irq_shutdown = cp2112_gpio_irq_shutdown,
                     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-cp2112.c:1175:18: note: (near initialization for 'cp2112_gpio_irqchip')
>> drivers/hid/hid-cp2112.c:1176:2: error: unknown field 'irq_ack' specified in initializer
     .irq_ack = cp2112_gpio_irq_ack,
     ^
   drivers/hid/hid-cp2112.c:1176:13: warning: excess elements in struct initializer
     .irq_ack = cp2112_gpio_irq_ack,
                ^~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-cp2112.c:1176:13: note: (near initialization for 'cp2112_gpio_irqchip')
>> drivers/hid/hid-cp2112.c:1177:2: error: unknown field 'irq_mask' specified in initializer
     .irq_mask = cp2112_gpio_irq_mask,
     ^
   drivers/hid/hid-cp2112.c:1177:14: warning: excess elements in struct initializer
     .irq_mask = cp2112_gpio_irq_mask,
                 ^~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-cp2112.c:1177:14: note: (near initialization for 'cp2112_gpio_irqchip')
>> drivers/hid/hid-cp2112.c:1178:2: error: unknown field 'irq_unmask' specified in initializer
     .irq_unmask = cp2112_gpio_irq_unmask,
     ^
   drivers/hid/hid-cp2112.c:1178:16: warning: excess elements in struct initializer
     .irq_unmask = cp2112_gpio_irq_unmask,
                   ^~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-cp2112.c:1178:16: note: (near initialization for 'cp2112_gpio_irqchip')
>> drivers/hid/hid-cp2112.c:1179:2: error: unknown field 'irq_set_type' specified in initializer
     .irq_set_type = cp2112_gpio_irq_type,
     ^
   drivers/hid/hid-cp2112.c:1179:18: warning: excess elements in struct initializer
     .irq_set_type = cp2112_gpio_irq_type,
                     ^~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-cp2112.c:1179:18: note: (near initialization for 'cp2112_gpio_irqchip')
   drivers/hid/hid-cp2112.c: In function 'cp2112_probe':

vim +/pinconf_to_config_param +138 drivers//i2c/muxes/i2c-mux-ltc4306.c

dbed8a80 Michael Hennerich 2017-04-11  132  static int ltc4306_gpio_set_config(struct gpio_chip *chip,
dbed8a80 Michael Hennerich 2017-04-11  133  				   unsigned int offset, unsigned long config)
dbed8a80 Michael Hennerich 2017-04-11  134  {
dbed8a80 Michael Hennerich 2017-04-11  135  	struct ltc4306 *data = gpiochip_get_data(chip);
dbed8a80 Michael Hennerich 2017-04-11  136  	unsigned int val;
dbed8a80 Michael Hennerich 2017-04-11  137  
dbed8a80 Michael Hennerich 2017-04-11 @138  	switch (pinconf_to_config_param(config)) {
dbed8a80 Michael Hennerich 2017-04-11 @139  	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
dbed8a80 Michael Hennerich 2017-04-11  140  		val = 0;
dbed8a80 Michael Hennerich 2017-04-11  141  		break;
dbed8a80 Michael Hennerich 2017-04-11 @142  	case PIN_CONFIG_DRIVE_PUSH_PULL:
dbed8a80 Michael Hennerich 2017-04-11  143  		val = BIT(4 - offset);
dbed8a80 Michael Hennerich 2017-04-11  144  		break;
dbed8a80 Michael Hennerich 2017-04-11  145  	default:

:::::: The code at line 138 was first introduced by commit
:::::: dbed8a803bd3fb64339a6180adaff2cec46242ce i2c: mux: ltc4306: LTC4306 and LTC4305 I2C multiplexer/switch

:::::: TO: Michael Hennerich <michael.hennerich@analog.com>
:::::: CC: Peter Rosin <peda@axentia.se>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 45650 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170706/508a4fb4/attachment-0001.gz>
