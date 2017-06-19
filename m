From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 19 Jun 2017 20:49:46 +0800
Subject: [arm-soc:mediatek/dts64 6/13]
 arch/arm64/boot/dts/mediatek/mt6797.dtsi:15:44: fatal error:
 dt-bindings/power/mt6797-power.h: No such file or directory
Message-ID: <201706192044.SQGHZhTL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mars,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git mediatek/dts64
head:   5f0047466e3c653ffc95fe72e1ea19b1f9927e48
commit: 003f5d0c3462ff9b7fb251cf0c9e5f08712018b2 [6/13] arm64: dts: mediatek: add clk and scp nodes for MT6797
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 003f5d0c3462ff9b7fb251cf0c9e5f08712018b2
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/mediatek/mt6797-evb.dts:16:0:
>> arch/arm64/boot/dts/mediatek/mt6797.dtsi:15:44: fatal error: dt-bindings/power/mt6797-power.h: No such file or directory
    #include <dt-bindings/power/mt6797-power.h>
                                               ^
   compilation terminated.

vim +15 arch/arm64/boot/dts/mediatek/mt6797.dtsi

     9	 * This program is distributed in the hope that it will be useful,
    10	 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    11	 * GNU General Public License for more details.
    12	 */
    13	
    14	#include <dt-bindings/clock/mt6797-clk.h>
  > 15	#include <dt-bindings/power/mt6797-power.h>
    16	#include <dt-bindings/interrupt-controller/irq.h>
    17	#include <dt-bindings/interrupt-controller/arm-gic.h>
    18	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 55797 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170619/f1b1a8fa/attachment-0001.gz>
