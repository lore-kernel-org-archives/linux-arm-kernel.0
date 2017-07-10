From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 10 Jul 2017 13:54:43 +0800
Subject: [arm:drm-dwhdmi-devel 1/4]
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c:1760:26: error: 'HDMI_CEC_MASK'
 undeclared
Message-ID: <201707101331.izrmLHWI%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git drm-dwhdmi-devel
head:   6916d37b572042c01ad9c87a18be3d096fb1d6ba
commit: 302a868d45da97c06419bc7fe0f05e186c589337 [1/4] drm/bridge: dw-hdmi: remove CEC engine register definitions
config: i386-randconfig-c0-07101214 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        git checkout 302a868d45da97c06419bc7fe0f05e186c589337
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: the arm/drm-dwhdmi-devel HEAD 6916d37b572042c01ad9c87a18be3d096fb1d6ba builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c: In function 'initialize_hdmi_ih_mutes':
>> drivers/gpu/drm/bridge/synopsys/dw-hdmi.c:1760:26: error: 'HDMI_CEC_MASK' undeclared (first use in this function)
     hdmi_writeb(hdmi, 0xff, HDMI_CEC_MASK);
                             ^
   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c:1760:26: note: each undeclared identifier is reported only once for each function it appears in

vim +/HDMI_CEC_MASK +1760 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c


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
Size: 31186 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170710/01f4c3e5/attachment-0001.gz>
