From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 5 Jun 2017 18:21:00 +0800
Subject: [arm:drm-dwhdmi-devel 1/4]
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c:1760:26: error: 'HDMI_CEC_MASK'
 undeclared
Message-ID: <201706051853.I12D7XI0%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git drm-dwhdmi-devel
head:   5e86b869a302f6c55ce6dea98cbe3281ece3e360
commit: 3ceb3d41f900030fa03ba6116d518d1963b42b5c [1/4] drm/bridge: dw-hdmi: remove CEC engine register definitions
config: i386-randconfig-x078-06041529 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 3ceb3d41f900030fa03ba6116d518d1963b42b5c
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: the arm/drm-dwhdmi-devel HEAD 5e86b869a302f6c55ce6dea98cbe3281ece3e360 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c: In function 'initialize_hdmi_ih_mutes':
>> drivers/gpu/drm/bridge/synopsys/dw-hdmi.c:1760:26: error: 'HDMI_CEC_MASK' undeclared (first use in this function)
     hdmi_writeb(hdmi, 0xff, HDMI_CEC_MASK);
                             ^~~~~~~~~~~~~
   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c:1760:26: note: each undeclared identifier is reported only once for each function it appears in

vim +/HDMI_CEC_MASK +1760 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c

9aaf880e drivers/staging/imx-drm/imx-hdmi.c Fabio Estevam 2013-11-29  1754  	hdmi_writeb(hdmi, 0xff, HDMI_PHY_I2CM_CTLINT_ADDR);
9aaf880e drivers/staging/imx-drm/imx-hdmi.c Fabio Estevam 2013-11-29  1755  	hdmi_writeb(hdmi, 0xff, HDMI_AUD_INT);
9aaf880e drivers/staging/imx-drm/imx-hdmi.c Fabio Estevam 2013-11-29  1756  	hdmi_writeb(hdmi, 0xff, HDMI_AUD_SPDIFINT);
9aaf880e drivers/staging/imx-drm/imx-hdmi.c Fabio Estevam 2013-11-29  1757  	hdmi_writeb(hdmi, 0xff, HDMI_AUD_HBR_MASK);
9aaf880e drivers/staging/imx-drm/imx-hdmi.c Fabio Estevam 2013-11-29  1758  	hdmi_writeb(hdmi, 0xff, HDMI_GP_MASK);
9aaf880e drivers/staging/imx-drm/imx-hdmi.c Fabio Estevam 2013-11-29  1759  	hdmi_writeb(hdmi, 0xff, HDMI_A_APIINTMSK);
9aaf880e drivers/staging/imx-drm/imx-hdmi.c Fabio Estevam 2013-11-29 @1760  	hdmi_writeb(hdmi, 0xff, HDMI_CEC_MASK);
9aaf880e drivers/staging/imx-drm/imx-hdmi.c Fabio Estevam 2013-11-29  1761  	hdmi_writeb(hdmi, 0xff, HDMI_I2CM_INT);
9aaf880e drivers/staging/imx-drm/imx-hdmi.c Fabio Estevam 2013-11-29  1762  	hdmi_writeb(hdmi, 0xff, HDMI_I2CM_CTLINT);
9aaf880e drivers/staging/imx-drm/imx-hdmi.c Fabio Estevam 2013-11-29  1763  

:::::: The code at line 1760 was first introduced by commit
:::::: 9aaf880ed4ee3c3cb1aa628e76c177035ce000ae imx-drm: Add mx6 hdmi transmitter support

:::::: TO: Fabio Estevam <fabio.estevam@freescale.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28183 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170605/da7c6744/attachment-0001.gz>
