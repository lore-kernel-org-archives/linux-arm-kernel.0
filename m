From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 20 Nov 2016 10:21:20 +0800
Subject: [arm-soc:sunxi/dt64 3/3]
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi:45:46: fatal error:
 dt-bindings/clock/sun50i-a64-ccu.h: No such file or directory
Message-ID: <201611201033.0KrzgfES%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git sunxi/dt64
head:   4e3886081848b7ea16452a92c4324acaab644d49
commit: 4e3886081848b7ea16452a92c4324acaab644d49 [3/3] arm64: dts: add Pine64 support
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 4e3886081848b7ea16452a92c4324acaab644d49
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts:45:0,
                    from arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts:43:
>> arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi:45:46: fatal error: dt-bindings/clock/sun50i-a64-ccu.h: No such file or directory
    #include <dt-bindings/clock/sun50i-a64-ccu.h>
                                                 ^
   compilation terminated.

vim +45 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi

6bc37fac Andre Przywara 2016-01-18  29   *     Software is furnished to do so, subject to the following
6bc37fac Andre Przywara 2016-01-18  30   *     conditions:
6bc37fac Andre Przywara 2016-01-18  31   *
6bc37fac Andre Przywara 2016-01-18  32   *     The above copyright notice and this permission notice shall be
6bc37fac Andre Przywara 2016-01-18  33   *     included in all copies or substantial portions of the Software.
6bc37fac Andre Przywara 2016-01-18  34   *
6bc37fac Andre Przywara 2016-01-18  35   *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
6bc37fac Andre Przywara 2016-01-18  36   *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
6bc37fac Andre Przywara 2016-01-18  37   *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
6bc37fac Andre Przywara 2016-01-18  38   *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
6bc37fac Andre Przywara 2016-01-18  39   *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
6bc37fac Andre Przywara 2016-01-18  40   *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
6bc37fac Andre Przywara 2016-01-18  41   *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
6bc37fac Andre Przywara 2016-01-18  42   *     OTHER DEALINGS IN THE SOFTWARE.
6bc37fac Andre Przywara 2016-01-18  43   */
6bc37fac Andre Przywara 2016-01-18  44  
6bc37fac Andre Przywara 2016-01-18 @45  #include <dt-bindings/clock/sun50i-a64-ccu.h>
6bc37fac Andre Przywara 2016-01-18  46  #include <dt-bindings/interrupt-controller/arm-gic.h>
6bc37fac Andre Przywara 2016-01-18  47  #include <dt-bindings/pinctrl/sun4i-a10.h>
6bc37fac Andre Przywara 2016-01-18  48  #include <dt-bindings/reset/sun50i-a64-ccu.h>
6bc37fac Andre Przywara 2016-01-18  49  
6bc37fac Andre Przywara 2016-01-18  50  / {
6bc37fac Andre Przywara 2016-01-18  51  	interrupt-parent = <&gic>;
6bc37fac Andre Przywara 2016-01-18  52  	#address-cells = <1>;
6bc37fac Andre Przywara 2016-01-18  53  	#size-cells = <1>;

:::::: The code at line 45 was first introduced by commit
:::::: 6bc37fac30cf01c39feb17834090089304bd1d31 arm64: dts: add Allwinner A64 SoC .dtsi

:::::: TO: Andre Przywara <andre.przywara@arm.com>
:::::: CC: Maxime Ripard <maxime.ripard@free-electrons.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 32759 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161120/3facb00b/attachment-0001.gz>
