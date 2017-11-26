From: lkp@intel.com (kbuild test robot)
Date: Mon, 27 Nov 2017 01:32:57 +0800
Subject: [PATCH v2 03/11] media: rkisp1: add rockchip isp1 driver
In-Reply-To: <20171124023706.5702-4-jacob-chen@iotwrt.com>
References: <20171124023706.5702-4-jacob-chen@iotwrt.com>
Message-ID: <201711270005.B4X2tZ0p%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacob,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on next-20171124]
[cannot apply to rockchip/for-next v4.14]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jacob-Chen/Rockchip-ISP1-Driver/20171126-224713
base:   git://linuxtv.org/media_tree.git master
config: mips-allmodconfig (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All error/warnings (new ones prefixed by >>):

   drivers/media//platform/rockchip/isp1/rkisp1.c: In function 'rkisp1_isp_sd_s_stream':
>> drivers/media//platform/rockchip/isp1/rkisp1.c:136:6: warning: 'isp_ctrl' may be used uninitialized in this function [-Wmaybe-uninitialized]
     u32 isp_ctrl;
         ^~~~~~~~
>> drivers/media//platform/rockchip/isp1/rkisp1.c:209:2: warning: 'acq_mult' may be used uninitialized in this function [-Wmaybe-uninitialized]
     writel(acq_mult * in_frm->width, base + CIF_ISP_ACQ_H_SIZE);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media//platform/rockchip/isp1/rkisp1.c:139:6: note: 'acq_mult' was declared here
     u32 acq_mult;
         ^~~~~~~~
--
   drivers/media//platform/rockchip/isp1/dev.c: In function 'rkisp1_runtime_suspend':
   drivers/media//platform/rockchip/isp1/dev.c:597:9: error: implicit declaration of function 'pinctrl_pm_select_sleep_state' [-Werror=implicit-function-declaration]
     return pinctrl_pm_select_sleep_state(dev);
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media//platform/rockchip/isp1/dev.c: In function 'rkisp1_runtime_resume':
>> drivers/media//platform/rockchip/isp1/dev.c:605:8: error: implicit declaration of function 'pinctrl_pm_select_default_state'; did you mean 'irq_set_default_host'? [-Werror=implicit-function-declaration]
     ret = pinctrl_pm_select_default_state(dev);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
           irq_set_default_host
   cc1: some warnings being treated as errors
--
>> drivers/media//platform/rockchip/isp1/isp_params.c:1350:3: error: 'const struct v4l2_ioctl_ops' has no member named 'vidioc_enum_fmt_meta_out'; did you mean 'vidioc_enum_fmt_meta_cap'?
     .vidioc_enum_fmt_meta_out = rkisp1_params_enum_fmt_meta_out,
      ^~~~~~~~~~~~~~~~~~~~~~~~
      vidioc_enum_fmt_meta_cap
   drivers/media//platform/rockchip/isp1/isp_params.c:1350:30: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .vidioc_enum_fmt_meta_out = rkisp1_params_enum_fmt_meta_out,
                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media//platform/rockchip/isp1/isp_params.c:1350:30: note: (near initialization for 'rkisp1_params_ioctl.vidioc_g_std')
>> drivers/media//platform/rockchip/isp1/isp_params.c:1351:3: error: 'const struct v4l2_ioctl_ops' has no member named 'vidioc_g_fmt_meta_out'; did you mean 'vidioc_g_fmt_meta_cap'?
     .vidioc_g_fmt_meta_out = rkisp1_params_g_fmt_meta_out,
      ^~~~~~~~~~~~~~~~~~~~~
      vidioc_g_fmt_meta_cap
   drivers/media//platform/rockchip/isp1/isp_params.c:1351:27: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .vidioc_g_fmt_meta_out = rkisp1_params_g_fmt_meta_out,
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media//platform/rockchip/isp1/isp_params.c:1351:27: note: (near initialization for 'rkisp1_params_ioctl.vidioc_s_std')
>> drivers/media//platform/rockchip/isp1/isp_params.c:1352:3: error: 'const struct v4l2_ioctl_ops' has no member named 'vidioc_s_fmt_meta_out'; did you mean 'vidioc_s_fmt_meta_cap'?
     .vidioc_s_fmt_meta_out = rkisp1_params_g_fmt_meta_out,
      ^~~~~~~~~~~~~~~~~~~~~
      vidioc_s_fmt_meta_cap
   drivers/media//platform/rockchip/isp1/isp_params.c:1352:27: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .vidioc_s_fmt_meta_out = rkisp1_params_g_fmt_meta_out,
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media//platform/rockchip/isp1/isp_params.c:1352:27: note: (near initialization for 'rkisp1_params_ioctl.vidioc_querystd')
>> drivers/media//platform/rockchip/isp1/isp_params.c:1353:3: error: 'const struct v4l2_ioctl_ops' has no member named 'vidioc_try_fmt_meta_out'; did you mean 'vidioc_try_fmt_meta_cap'?
     .vidioc_try_fmt_meta_out = rkisp1_params_g_fmt_meta_out,
      ^~~~~~~~~~~~~~~~~~~~~~~
      vidioc_try_fmt_meta_cap
   drivers/media//platform/rockchip/isp1/isp_params.c:1353:29: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .vidioc_try_fmt_meta_out = rkisp1_params_g_fmt_meta_out,
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media//platform/rockchip/isp1/isp_params.c:1353:29: note: (near initialization for 'rkisp1_params_ioctl.vidioc_enum_input')
   drivers/media//platform/rockchip/isp1/isp_params.c: In function 'rkisp1_params_init_vb2_queue':
>> drivers/media//platform/rockchip/isp1/isp_params.c:1478:12: error: 'V4L2_BUF_TYPE_META_OUTPUT' undeclared (first use in this function); did you mean 'V4L2_BUF_TYPE_SDR_OUTPUT'?
     q->type = V4L2_BUF_TYPE_META_OUTPUT;
               ^~~~~~~~~~~~~~~~~~~~~~~~~
               V4L2_BUF_TYPE_SDR_OUTPUT
   drivers/media//platform/rockchip/isp1/isp_params.c:1478:12: note: each undeclared identifier is reported only once for each function it appears in
   drivers/media//platform/rockchip/isp1/isp_params.c: In function 'rkisp1_register_params_vdev':
>> drivers/media//platform/rockchip/isp1/isp_params.c:1523:43: error: 'V4L2_CAP_META_OUTPUT' undeclared (first use in this function); did you mean 'V4L2_CAP_RDS_OUTPUT'?
     vdev->device_caps = V4L2_CAP_STREAMING | V4L2_CAP_META_OUTPUT;
                                              ^~~~~~~~~~~~~~~~~~~~
                                              V4L2_CAP_RDS_OUTPUT
   cc1: some warnings being treated as errors

vim +605 drivers/media//platform/rockchip/isp1/dev.c

   591	
   592	static int __maybe_unused rkisp1_runtime_suspend(struct device *dev)
   593	{
   594		struct rkisp1_device *isp_dev = dev_get_drvdata(dev);
   595	
   596		rkisp1_disable_sys_clk(isp_dev);
 > 597		return pinctrl_pm_select_sleep_state(dev);
   598	}
   599	
   600	static int __maybe_unused rkisp1_runtime_resume(struct device *dev)
   601	{
   602		struct rkisp1_device *isp_dev = dev_get_drvdata(dev);
   603		int ret;
   604	
 > 605		ret = pinctrl_pm_select_default_state(dev);
   606		if (ret < 0)
   607			return ret;
   608		rkisp1_enable_sys_clk(isp_dev);
   609	
   610		return 0;
   611	}
   612	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 47597 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171127/1c7765ae/attachment-0001.gz>
