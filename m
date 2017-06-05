From: lkp@intel.com (kbuild test robot)
Date: Mon, 5 Jun 2017 16:31:22 +0800
Subject: [PATCH 2/2] arm64: allwinner: a64: Convert CCU raw number
 references to macros
In-Reply-To: <20170605043224.20687-3-wens@csie.org>
Message-ID: <201706051615.6ow32cIq%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.12-rc4 next-20170602]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chen-Yu-Tsai/ARM-arm64-sunxi-convert-CCU-raw-numbers-to-macros/20170605-124326
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts:45:0,
                    from arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts:43:
>> arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi:46:42: fatal error: dt-bindings/clock/sun8-r-ccu.h: No such file or directory
    #include <dt-bindings/clock/sun8-r-ccu.h>
                                             ^
   compilation terminated.

vim +46 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi

    40	 *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    41	 *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
    42	 *     OTHER DEALINGS IN THE SOFTWARE.
    43	 */
    44	
    45	#include <dt-bindings/clock/sun50i-a64-ccu.h>
  > 46	#include <dt-bindings/clock/sun8-r-ccu.h>
    47	#include <dt-bindings/interrupt-controller/arm-gic.h>
    48	#include <dt-bindings/reset/sun50i-a64-ccu.h>
    49	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 35196 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170605/86fef3f0/attachment-0001.gz>
