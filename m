From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 13 May 2017 12:18:26 +0800
Subject: [arm-soc:to-build 1/1]
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts:47:57: fatal error:
 include/dt-bindings/input/linux-event-codes.h: No such file or directory
Message-ID: <201705131223.4fYRjiWX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git to-build
head:   4ab8a17555b2c193d0089010a1459d1206a901f0
commit: 4ab8a17555b2c193d0089010a1459d1206a901f0 [1/1] devicetree: Move include prefixes from arch to separate directory
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 4ab8a17555b2c193d0089010a1459d1206a901f0
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts:47:57: fatal error: include/dt-bindings/input/linux-event-codes.h: No such file or directory
    #include <include/dt-bindings/input/linux-event-codes.h>
                                                            ^
   compilation terminated.

vim +47 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts

48f4d979 Brian Norris 2017-03-20  31   *
48f4d979 Brian Norris 2017-03-20  32   *     The above copyright notice and this permission notice shall be
48f4d979 Brian Norris 2017-03-20  33   *     included in all copies or substantial portions of the Software.
48f4d979 Brian Norris 2017-03-20  34   *
48f4d979 Brian Norris 2017-03-20  35   *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
48f4d979 Brian Norris 2017-03-20  36   *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
48f4d979 Brian Norris 2017-03-20  37   *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
48f4d979 Brian Norris 2017-03-20  38   *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
48f4d979 Brian Norris 2017-03-20  39   *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
48f4d979 Brian Norris 2017-03-20  40   *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
48f4d979 Brian Norris 2017-03-20  41   *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
48f4d979 Brian Norris 2017-03-20  42   *     OTHER DEALINGS IN THE SOFTWARE.
48f4d979 Brian Norris 2017-03-20  43   */
48f4d979 Brian Norris 2017-03-20  44  
48f4d979 Brian Norris 2017-03-20  45  /dts-v1/;
48f4d979 Brian Norris 2017-03-20  46  #include "rk3399-gru.dtsi"
48f4d979 Brian Norris 2017-03-20 @47  #include <include/dt-bindings/input/linux-event-codes.h>
48f4d979 Brian Norris 2017-03-20  48  
48f4d979 Brian Norris 2017-03-20  49  /*
48f4d979 Brian Norris 2017-03-20  50   * Kevin-specific things
48f4d979 Brian Norris 2017-03-20  51   *
48f4d979 Brian Norris 2017-03-20  52   * Things in this section should use names from Kevin schematic since no
48f4d979 Brian Norris 2017-03-20  53   * equivalent exists in Gru schematic.  If referring to signals that exist
48f4d979 Brian Norris 2017-03-20  54   * in Gru we use the Gru names, though.  Confusing enough for you?
48f4d979 Brian Norris 2017-03-20  55   */

:::::: The code at line 47 was first introduced by commit
:::::: 48f4d9796d990850f6339b61eeeac9ca7fdb3695 arm64: dts: rockchip: add Gru/Kevin DTS

:::::: TO: Brian Norris <briannorris@chromium.org>
:::::: CC: Heiko Stuebner <heiko@sntech.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 35119 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170513/5aa68a77/attachment-0001.gz>
