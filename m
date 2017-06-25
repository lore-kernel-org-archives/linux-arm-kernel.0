From: lkp@intel.com (kbuild test robot)
Date: Sun, 25 Jun 2017 20:36:44 +0800
Subject: [PATCH v1 5/6] [media] ov9650: add multiple variant support
In-Reply-To: <1498143942-12682-6-git-send-email-hugues.fruchet@st.com>
Message-ID: <201706252047.pFxzMQ74%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hugues,

[auto build test WARNING on linuxtv-media/master]
[also build test WARNING on v4.12-rc6 next-20170623]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Hugues-Fruchet/Add-support-of-OV9655-camera/20170625-201153
base:   git://linuxtv.org/media_tree.git master
config: i386-randconfig-x079-06251032 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/media//i2c/ov9650.c: In function 'ov965x_probe':
>> drivers/media//i2c/ov9650.c:1617:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     if (ov965x->initialize_controls)
     ^~
   drivers/media//i2c/ov9650.c:1619:3: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
      if (ret < 0)
      ^~
   Cyclomatic Complexity 1 include/linux/err.h:PTR_ERR
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:fls
   Cyclomatic Complexity 1 include/linux/device.h:dev_get_drvdata
   Cyclomatic Complexity 1 include/asm-generic/gpio.h:gpio_is_valid
   Cyclomatic Complexity 1 include/linux/i2c.h:i2c_get_clientdata
   Cyclomatic Complexity 1 include/media/media-entity.h:media_entity_cleanup
   Cyclomatic Complexity 1 include/media/v4l2-subdev.h:v4l2_get_subdevdata
   Cyclomatic Complexity 1 drivers/media//i2c/ov9650.c:ctrl_to_sd
   Cyclomatic Complexity 1 drivers/media//i2c/ov9650.c:to_ov965x
   Cyclomatic Complexity 1 drivers/media//i2c/ov9650.c:ov965x_get_default_format
   Cyclomatic Complexity 2 drivers/media//i2c/ov9650.c:ov965x_enum_mbus_code
   Cyclomatic Complexity 4 drivers/media//i2c/ov9650.c:ov965x_enum_frame_sizes
   Cyclomatic Complexity 6 drivers/media//i2c/ov9650.c:__ov965x_try_frame_size
   Cyclomatic Complexity 1 drivers/media//i2c/ov9650.c:ov965x_i2c_driver_init
   Cyclomatic Complexity 1 drivers/media//i2c/ov9650.c:ov965x_remove
   Cyclomatic Complexity 8 drivers/media//i2c/ov9650.c:__ov965x_set_frame_interval
   Cyclomatic Complexity 5 drivers/media//i2c/ov9650.c:ov965x_read
   Cyclomatic Complexity 11 drivers/media//i2c/ov9650.c:__g_volatile_ctrl
   Cyclomatic Complexity 3 drivers/media//i2c/ov9650.c:ov965x_write
   Cyclomatic Complexity 3 drivers/media//i2c/ov9650.c:ov965x_write_array
   Cyclomatic Complexity 2 drivers/media//i2c/ov9650.c:ov965x_set_frame_size
   Cyclomatic Complexity 3 drivers/media//i2c/ov9650.c:ov965x_set_default_gamma_curve
   Cyclomatic Complexity 3 drivers/media//i2c/ov9650.c:ov965x_set_color_matrix
   Cyclomatic Complexity 5 drivers/media//i2c/ov9650.c:ov965x_set_white_balance
   Cyclomatic Complexity 3 drivers/media//i2c/ov9650.c:ov965x_set_brightness
   Cyclomatic Complexity 12 drivers/media//i2c/ov9650.c:ov965x_set_gain
   Cyclomatic Complexity 3 drivers/media//i2c/ov9650.c:ov965x_set_flip
   Cyclomatic Complexity 3 drivers/media//i2c/ov9650.c:ov965x_set_saturation
   Cyclomatic Complexity 6 drivers/media//i2c/ov9650.c:ov965x_set_sharpness
   Cyclomatic Complexity 3 drivers/media//i2c/ov9650.c:ov965x_set_test_pattern
   Cyclomatic Complexity 7 drivers/media//i2c/ov9650.c:ov965x_set_banding_filter
   Cyclomatic Complexity 10 drivers/media//i2c/ov9650.c:__ov965x_set_params
   Cyclomatic Complexity 1 include/linux/err.h:IS_ERR
   Cyclomatic Complexity 1 include/media/v4l2-ctrls.h:v4l2_ctrl_lock
   Cyclomatic Complexity 1 include/media/v4l2-ctrls.h:v4l2_ctrl_unlock
   Cyclomatic Complexity 2 drivers/media//i2c/ov9650.c:ov965x_g_volatile_ctrl
   Cyclomatic Complexity 3 drivers/media//i2c/ov9650.c:ov965x_s_frame_interval
   Cyclomatic Complexity 2 drivers/media//i2c/ov9650.c:ov965x_g_frame_interval
   Cyclomatic Complexity 1 include/media/v4l2-ctrls.h:v4l2_ctrl_modify_range
   Cyclomatic Complexity 7 drivers/media//i2c/ov9650.c:ov965x_update_exposure_ctrl
   Cyclomatic Complexity 3 drivers/media//i2c/ov9650.c:ov965x_initialize_controls
   Cyclomatic Complexity 10 drivers/media//i2c/ov9650.c:ov965x_set_exposure
   Cyclomatic Complexity 12 drivers/media//i2c/ov9650.c:ov965x_s_ctrl
   Cyclomatic Complexity 1 include/media/v4l2-subdev.h:v4l2_subdev_get_try_format
   Cyclomatic Complexity 1 drivers/media//i2c/ov9650.c:ov965x_open
   Cyclomatic Complexity 11 drivers/media//i2c/ov9650.c:ov965x_set_fmt
   Cyclomatic Complexity 2 drivers/media//i2c/ov9650.c:ov965x_get_fmt
   Cyclomatic Complexity 13 drivers/media//i2c/ov9650.c:ov965x_s_stream
   Cyclomatic Complexity 2 drivers/media//i2c/ov9650.c:ov965x_gpio_set
   Cyclomatic Complexity 2 drivers/media//i2c/ov9650.c:__ov965x_set_power
   Cyclomatic Complexity 7 drivers/media//i2c/ov9650.c:ov965x_s_power
   Cyclomatic Complexity 4 drivers/media//i2c/ov9650.c:ov965x_detect_sensor
   Cyclomatic Complexity 1 include/linux/device.h:devm_kzalloc
   Cyclomatic Complexity 1 include/asm-generic/gpio.h:__gpio_set_value
   Cyclomatic Complexity 1 include/linux/gpio.h:gpio_set_value
   Cyclomatic Complexity 1 include/asm-generic/gpio.h:gpio_export
   Cyclomatic Complexity 5 drivers/media//i2c/ov9650.c:ov965x_configure_gpios
   Cyclomatic Complexity 14 drivers/media//i2c/ov9650.c:ov965x_probe
   Cyclomatic Complexity 1 drivers/media//i2c/ov9650.c:ov965x_i2c_driver_exit

vim +/if +1617 drivers/media//i2c/ov9650.c

  1601		ov965x->init_regs = ov965x_init_regs;
  1602		ov965x->initialize_controls = ov965x_initialize_controls;
  1603		ov965x->framesizes = ov965x_framesizes;
  1604		ov965x->nb_of_framesizes = ARRAY_SIZE(ov965x_framesizes);
  1605		ov965x->formats = ov965x_formats;
  1606		ov965x->nb_of_formats = ARRAY_SIZE(ov965x_formats);
  1607		ov965x->intervals = ov965x_intervals;
  1608		ov965x->nb_of_intervals = ARRAY_SIZE(ov965x_intervals);
  1609		ov965x->fiv = &ov965x_intervals[0];
  1610		ov965x->set_frame_interval = __ov965x_set_frame_interval;
  1611		ov965x->update_exposure_ctrl = ov965x_update_exposure_ctrl;
  1612		ov965x->set_params = __ov965x_set_params;
  1613	
  1614		ov965x->frame_size = &ov965x->framesizes[0];
  1615		ov965x_get_default_format(ov965x, &ov965x->format);
  1616	
> 1617		if (ov965x->initialize_controls)
  1618			ret = ov965x->initialize_controls(ov965x);
  1619			if (ret < 0)
  1620				goto err_ctrls;
  1621	
  1622		/* Update exposure time min/max to match frame format */
  1623		if (ov965x->update_exposure_ctrl)
  1624			ov965x->update_exposure_ctrl(ov965x);
  1625	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 24934 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170625/39ead4c2/attachment-0001.gz>
