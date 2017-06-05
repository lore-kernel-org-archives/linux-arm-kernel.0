From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 5 Jun 2017 21:24:59 +0800
Subject: [arm:drm-dwhdmi-devel 4/4]
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c:109:10: error:
 'CEC_CTRL_IMMED' undeclared
Message-ID: <201706052154.KUcy5u0F%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git drm-dwhdmi-devel
head:   5e86b869a302f6c55ce6dea98cbe3281ece3e360
commit: 5e86b869a302f6c55ce6dea98cbe3281ece3e360 [4/4] drm/bridge: dw-hdmi: add cec driver
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 5e86b869a302f6c55ce6dea98cbe3281ece3e360
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c: In function 'dw_hdmi_cec_transmit':
>> drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c:109:10: error: 'CEC_CTRL_IMMED' undeclared (first use in this function)
      ctrl = CEC_CTRL_IMMED;
             ^~~~~~~~~~~~~~
   drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c:109:10: note: each undeclared identifier is reported only once for each function it appears in

vim +/CEC_CTRL_IMMED +109 drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c

   103			break;
   104		case CEC_SIGNAL_FREE_TIME_NEW_INITIATOR:
   105		default:
   106			ctrl = CEC_CTRL_NORMAL;
   107			break;
   108		case CEC_SIGNAL_FREE_TIME_NEXT_XFER:
 > 109			ctrl = CEC_CTRL_IMMED;
   110			break;
   111		}
   112	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 60107 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170605/e9c33b94/attachment-0001.gz>
