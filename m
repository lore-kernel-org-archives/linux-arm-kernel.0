From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 26 May 2017 17:29:12 +0200 (CEST)
Subject: [xlnx:2017.1_video_ea 21/28]
 drivers/gpu/drm/xilinx/crtc/mixer/hw/xilinx_mixer_hw.c:172:1-16:
 code aligned with following code on line 175 (fwd)
Message-ID: <alpine.DEB.2.20.1705261728430.2950@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The return on line 172 should be indented more.

julia

---------- Forwarded message ----------
Date: Fri, 26 May 2017 23:21:54 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild at 01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [xlnx:2017.1_video_ea 21/28]
    drivers/gpu/drm/xilinx/crtc/mixer/hw/xilinx_mixer_hw.c:172:1-16: code
    aligned with following code on line 175

CC: kbuild-all at 01.org
CC: linux-arm-kernel at lists.infradead.org
TO: Jeffrey Mouroux <jmouroux@xilinx.com>

tree:   https://github.com/Xilinx/linux-xlnx 2017.1_video_ea
head:   79a0e60e9f6535e89d9923e3987398318f0ed4e2
commit: de4c1196477747a8de4457931202255760f4533d [21/28] drm: xilinx: Extension of existing DRM driver to support new Video Mixer IP
:::::: branch date: 3 days ago
:::::: commit date: 9 days ago

>> drivers/gpu/drm/xilinx/crtc/mixer/hw/xilinx_mixer_hw.c:172:1-16: code aligned with following code on line 175

git remote add xlnx https://github.com/Xilinx/linux-xlnx
git remote update xlnx
git checkout de4c1196477747a8de4457931202255760f4533d
vim +172 drivers/gpu/drm/xilinx/crtc/mixer/hw/xilinx_mixer_hw.c

de4c1196 Jeffrey Mouroux 2017-05-08  166  		xilinx_mixer_get_layer_data(mixer, XVMIX_LAYER_MASTER);
de4c1196 Jeffrey Mouroux 2017-05-08  167
de4c1196 Jeffrey Mouroux 2017-05-08  168  	void __iomem *reg_base_addr = mixer->reg_base_addr;
de4c1196 Jeffrey Mouroux 2017-05-08  169
de4c1196 Jeffrey Mouroux 2017-05-08  170  	if (hactive > ld->hw_config.max_width ||
de4c1196 Jeffrey Mouroux 2017-05-08  171  	    vactive > ld->hw_config.max_height)
de4c1196 Jeffrey Mouroux 2017-05-08 @172  	return -EINVAL;
de4c1196 Jeffrey Mouroux 2017-05-08  173
de4c1196 Jeffrey Mouroux 2017-05-08  174  	/* set resolution */
de4c1196 Jeffrey Mouroux 2017-05-08 @175  	reg_writel(reg_base_addr, XV_MIX_CTRL_ADDR_HWREG_HEIGHT_DATA, vactive);
de4c1196 Jeffrey Mouroux 2017-05-08  176  	reg_writel(reg_base_addr, XV_MIX_CTRL_ADDR_HWREG_WIDTH_DATA, hactive);
de4c1196 Jeffrey Mouroux 2017-05-08  177
de4c1196 Jeffrey Mouroux 2017-05-08  178  	ld->layer_regs.width  = hactive;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
