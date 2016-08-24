From: lkp@intel.com (kbuild test robot)
Date: Wed, 24 Aug 2016 12:16:48 +0800
Subject: [PATCH] dmaengine: mv_xor: Add support for IO (PCIe) src/dst areas
In-Reply-To: <20160817095318.28034-1-sr@denx.de>
Message-ID: <201608241240.aEXnCS9C%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.8-rc3 next-20160823]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Stefan-Roese/dmaengine-mv_xor-Add-support-for-IO-PCIe-src-dst-areas/20160817-175632
config: xtensa-allyesconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `set_param_ifnum':
>> ipmi_poweroff.c:(.text+0x10157c): undefined reference to `mvebu_mbus_get_io_win_info'
   drivers/built-in.o: In function `mv_xor_add_io_win':
   mv_xor.c:(.text+0x11039e): undefined reference to `mvebu_mbus_get_io_win_info'
   drivers/built-in.o: In function `mc13xxx_led_probe':
   leds-mc13783.c:(.init.text+0x39a9c): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15588)
   leds-mc13783.c:(.init.text+0x39b0c): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x155a8)
   leds-mc13783.c:(.init.text+0x39b28): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x155ac)
   leds-mc13783.c:(.init.text+0x39b46): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x155b0)
   leds-mc13783.c:(.init.text+0x39b5c): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x155b4)
   leds-mc13783.c:(.init.text+0x39b95): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x155b8)
   leds-mc13783.c:(.init.text+0x39b13): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x155fc)
   leds-mc13783.c:(.init.text+0x39b2f): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15600)
   leds-mc13783.c:(.init.text+0x39b87): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15604)
   leds-mc13783.c:(.init.text+0x39b9e): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15608)
   leds-mc13783.c:(.init.text+0x39be0): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x1560c)
   drivers/built-in.o: In function `max77693_led_driver_init':
   leds-max77693.c:(.init.text+0x39bfb): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15610)
   leds-max77693.c:(.init.text+0x39c02): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15614)
   drivers/built-in.o: In function `max8997_led_driver_init':
   leds-max8997.c:(.init.text+0x39c0f): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15618)
   leds-max8997.c:(.init.text+0x39c16): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x1561c)
   drivers/built-in.o: In function `lm355x_i2c_driver_init':
   leds-lm355x.c:(.init.text+0x39c23): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15620)
   leds-lm355x.c:(.init.text+0x39c2a): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15624)
   drivers/built-in.o: In function `blinkm_driver_init':
   leds-blinkm.c:(.init.text+0x39c37): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15628)
   leds-blinkm.c:(.init.text+0x39c3e): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x1562c)
   drivers/built-in.o: In function `syscon_led_driver_init':
   leds-syscon.c:(.init.text+0x39c4b): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15630)
   leds-syscon.c:(.init.text+0x39c52): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15634)
   drivers/built-in.o: In function `menf21bmc_led_init':
   leds-menf21bmc.c:(.init.text+0x39c5f): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15638)
   leds-menf21bmc.c:(.init.text+0x39c66): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x1563c)
   drivers/built-in.o: In function `ktd2692_driver_init':
   leds-ktd2692.c:(.init.text+0x39c73): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15640)
   leds-ktd2692.c:(.init.text+0x39c7a): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15644)
   drivers/built-in.o: In function `is31fl32xx_driver_init':
   leds-is31fl32xx.c:(.init.text+0x39c87): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15648)
   leds-is31fl32xx.c:(.init.text+0x39c8e): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x1564c)
   drivers/built-in.o: In function `dac124s085_driver_init':
   leds-dac124s085.c:(.init.text+0x39c9b): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15650)
   leds-dac124s085.c:(.init.text+0x39ca2): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15654)
   drivers/built-in.o: In function `timer_trig_init':
   ledtrig-timer.c:(.init.text+0x39caf): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15658)
   ledtrig-timer.c:(.init.text+0x39cb4): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x1565c)
   drivers/built-in.o: In function `oneshot_trig_init':
   ledtrig-oneshot.c:(.init.text+0x39cc3): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15660)
   ledtrig-oneshot.c:(.init.text+0x39cc8): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15664)
   drivers/built-in.o: In function `ledtrig_disk_init':
   ledtrig-disk.c:(.init.text+0x39cd7): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15668)
   ledtrig-disk.c:(.init.text+0x39cda): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x1566c)
   ledtrig-disk.c:(.init.text+0x39ce5): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15670)
   ledtrig-disk.c:(.init.text+0x39ce8): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15674)
   ledtrig-disk.c:(.init.text+0x39cdf): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15678)
   ledtrig-disk.c:(.init.text+0x39cee): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x1567c)
   drivers/built-in.o: In function `ledtrig_mtd_init':
   ledtrig-mtd.c:(.init.text+0x39cfb): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15680)
   ledtrig-mtd.c:(.init.text+0x39cfe): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15684)
   ledtrig-mtd.c:(.init.text+0x39d09): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15688)
   ledtrig-mtd.c:(.init.text+0x39d0c): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x1568c)
   ledtrig-mtd.c:(.init.text+0x39d03): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15690)
   ledtrig-mtd.c:(.init.text+0x39d12): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15694)
   drivers/built-in.o: In function `heartbeat_trig_init':
   ledtrig-heartbeat.c:(.init.text+0x39d1f): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15698)
   ledtrig-heartbeat.c:(.init.text+0x39d30): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x1569c)
   ledtrig-heartbeat.c:(.init.text+0x39d33): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156a0)
   ledtrig-heartbeat.c:(.init.text+0x39d3c): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156a4)
   ledtrig-heartbeat.c:(.init.text+0x39d24): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156a8)
   ledtrig-heartbeat.c:(.init.text+0x39d36): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156ac)
   ledtrig-heartbeat.c:(.init.text+0x39d3f): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156b0)
   drivers/built-in.o: In function `bl_trig_init':
   ledtrig-backlight.c:(.init.text+0x39d4b): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156b4)
   ledtrig-backlight.c:(.init.text+0x39d50): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156b8)
   drivers/built-in.o: In function `gpio_trig_init':
   ledtrig-gpio.c:(.init.text+0x39d5f): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156bc)
   ledtrig-gpio.c:(.init.text+0x39d64): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156c0)
   drivers/built-in.o: In function `ledtrig_cpu_init':
   ledtrig-cpu.c:(.init.text+0x39d73): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156c4)
   ledtrig-cpu.c:(.init.text+0x39d76): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156c8)
   ledtrig-cpu.c:(.init.text+0x39d89): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156cc)
   ledtrig-cpu.c:(.init.text+0x39d94): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156d0)
   ledtrig-cpu.c:(.init.text+0x39d9d): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156d4)
   ledtrig-cpu.c:(.init.text+0x39da0): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156d8)
   ledtrig-cpu.c:(.init.text+0x39da3): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156dc)
   ledtrig-cpu.c:(.init.text+0x39db8): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156e0)
   ledtrig-cpu.c:(.init.text+0x39dc1): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156e4)
   ledtrig-cpu.c:(.init.text+0x39d83): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156e8)
   ledtrig-cpu.c:(.init.text+0x39d8e): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156ec)
   ledtrig-cpu.c:(.init.text+0x39d97): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156f0)
   ledtrig-cpu.c:(.init.text+0x39dac): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156f4)
   ledtrig-cpu.c:(.init.text+0x39dbb): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156f8)
   ledtrig-cpu.c:(.init.text+0x39dc6): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x156fc)
   drivers/built-in.o: In function `defon_trig_init':
   ledtrig-default-on.c:(.init.text+0x39dd3): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15700)
   ledtrig-default-on.c:(.init.text+0x39dd8): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15704)
   drivers/built-in.o: In function `transient_trig_init':
   ledtrig-transient.c:(.init.text+0x39de7): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15708)
   ledtrig-transient.c:(.init.text+0x39dec): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x1570c)
   drivers/built-in.o: In function `ledtrig_camera_init':
   ledtrig-camera.c:(.init.text+0x39dfb): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15710)
   ledtrig-camera.c:(.init.text+0x39dfe): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x15714)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 46046 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160824/5ff04d53/attachment-0001.obj>
