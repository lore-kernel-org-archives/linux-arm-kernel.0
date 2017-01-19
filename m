From: lkp@intel.com (kbuild test robot)
Date: Fri, 20 Jan 2017 07:31:36 +0800
Subject: [PATCH 2/7] iio: adc: stm32: Enable use of stm32 timer triggers
In-Reply-To: <1484832854-6314-3-git-send-email-fabrice.gasnier@st.com>
Message-ID: <201701200712.zoWuIMA4%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrice,

[auto build test ERROR on next-20170119]
[also build test ERROR on v4.10-rc4]
[cannot apply to iio/togreg robh/for-next v4.9-rc8 v4.9-rc7 v4.9-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Fabrice-Gasnier/Add-support-for-triggered-buffer-mode-to-STM32-ADC/20170120-062214
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> drivers/iio/adc/stm32-adc.c:26:49: fatal error: linux/iio/timer/stm32-timer-trigger.h: No such file or directory
    #include <linux/iio/timer/stm32-timer-trigger.h>
                                                    ^
   compilation terminated.

vim +26 drivers/iio/adc/stm32-adc.c

    20	 */
    21	
    22	#include <linux/clk.h>
    23	#include <linux/delay.h>
    24	#include <linux/iio/iio.h>
    25	#include <linux/iio/buffer.h>
  > 26	#include <linux/iio/timer/stm32-timer-trigger.h>
    27	#include <linux/iio/trigger.h>
    28	#include <linux/iio/trigger_consumer.h>
    29	#include <linux/iio/triggered_buffer.h>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 58121 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170120/99db8669/attachment-0001.gz>
