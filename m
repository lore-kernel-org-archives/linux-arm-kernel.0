From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 10 Apr 2017 01:54:54 +0800
Subject: [arm:cec-v18 3/11] drivers/gpu//drm/bridge/dw-hdmi.c:1508:26: error:
 'HDMI_CEC_MASK' undeclared
Message-ID: <201704100151.JgqtYMwd%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git cec-v18
head:   e33e18acc30ebb1f470da64079ed8890d8de034e
commit: f4f79759439ff9456c39a13b4d416fbfe7165b43 [3/11] drm/bridge: dw_hdmi: remove CEC engine register definitions
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout f4f79759439ff9456c39a13b4d416fbfe7165b43
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the arm/cec-v18 HEAD e33e18acc30ebb1f470da64079ed8890d8de034e builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/gpu//drm/bridge/dw-hdmi.c: In function 'initialize_hdmi_ih_mutes':
>> drivers/gpu//drm/bridge/dw-hdmi.c:1508:26: error: 'HDMI_CEC_MASK' undeclared (first use in this function)
     hdmi_writeb(hdmi, 0xff, HDMI_CEC_MASK);
                             ^~~~~~~~~~~~~
   drivers/gpu//drm/bridge/dw-hdmi.c:1508:26: note: each undeclared identifier is reported only once for each function it appears in

vim +/HDMI_CEC_MASK +1508 drivers/gpu//drm/bridge/dw-hdmi.c

9aaf880e drivers/staging/imx-drm/imx-hdmi.c Fabio Estevam 2013-11-29  1502  	hdmi_writeb(hdmi, 0xff, HDMI_PHY_I2CM_CTLINT_ADDR);
9aaf880e drivers/staging/imx-drm/imx-hdmi.c Fabio Estevam 2013-11-29  1503  	hdmi_writeb(hdmi, 0xff, HDMI_AUD_INT);
9aaf880e drivers/staging/imx-drm/imx-hdmi.c Fabio Estevam 2013-11-29  1504  	hdmi_writeb(hdmi, 0xff, HDMI_AUD_SPDIFINT);
9aaf880e drivers/staging/imx-drm/imx-hdmi.c Fabio Estevam 2013-11-29  1505  	hdmi_writeb(hdmi, 0xff, HDMI_AUD_HBR_MASK);
9aaf880e drivers/staging/imx-drm/imx-hdmi.c Fabio Estevam 2013-11-29  1506  	hdmi_writeb(hdmi, 0xff, HDMI_GP_MASK);
9aaf880e drivers/staging/imx-drm/imx-hdmi.c Fabio Estevam 2013-11-29  1507  	hdmi_writeb(hdmi, 0xff, HDMI_A_APIINTMSK);
9aaf880e drivers/staging/imx-drm/imx-hdmi.c Fabio Estevam 2013-11-29 @1508  	hdmi_writeb(hdmi, 0xff, HDMI_CEC_MASK);
9aaf880e drivers/staging/imx-drm/imx-hdmi.c Fabio Estevam 2013-11-29  1509  	hdmi_writeb(hdmi, 0xff, HDMI_I2CM_INT);
9aaf880e drivers/staging/imx-drm/imx-hdmi.c Fabio Estevam 2013-11-29  1510  	hdmi_writeb(hdmi, 0xff, HDMI_I2CM_CTLINT);
9aaf880e drivers/staging/imx-drm/imx-hdmi.c Fabio Estevam 2013-11-29  1511  

:::::: The code at line 1508 was first introduced by commit
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
Size: 39976 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170410/bcaed759/attachment-0001.gz>
