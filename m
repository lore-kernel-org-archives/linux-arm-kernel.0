From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 31 Mar 2017 09:43:40 +0800
Subject: [arm:cec-v18 6/12] imx-ocotp.c:undefined reference to
 `cec_get_edid_phys_addr'
Message-ID: <201703310937.rIJjJHda%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

It's probably a bug fix that unveils the link errors.

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git cec-v18
head:   803726e5c035daf0a07ecb33e9dc41c38f75d82e
commit: 6fb5bde0721478e580e3a88d25c66b6d9a4dd79e [6/12] drm/bridge: add dw-hdmi cec driver
config: arm-imx_v6_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 6fb5bde0721478e580e3a88d25c66b6d9a4dd79e
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `dw_hdmi_connector_get_modes':
>> imx-ocotp.c:(.text+0xd678c): undefined reference to `cec_get_edid_phys_addr'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 31045 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170331/f8ba8e73/attachment-0001.gz>
