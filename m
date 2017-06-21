From: lkp@intel.com (kbuild test robot)
Date: Wed, 21 Jun 2017 14:57:01 +0800
Subject: [PATCH 07/51] rtc: ab8500: stop using rtc deprecated functions
In-Reply-To: <1497951359-13334-8-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <201706211400.SuSzz7x6%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin,

[auto build test ERROR on abelloni/rtc-next]
[also build test ERROR on v4.12-rc6 next-20170620]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Benjamin-Gaignard/rtc-stop-using-rtc-deprecated-functions/20170621-044455
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
config: arm-u8500_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `ab8540_rtc_set_alarm':
>> drivers/rtc/rtc-ab8500.c:299: undefined reference to `__aeabi_uldivmod'
   drivers/rtc/rtc-ab8500.c:301: undefined reference to `__aeabi_uldivmod'
   drivers/built-in.o: In function `ab8500_rtc_set_time':
   drivers/rtc/rtc-ab8500.c:158: undefined reference to `__aeabi_uldivmod'
   drivers/rtc/rtc-ab8500.c:160: undefined reference to `__aeabi_uldivmod'
   drivers/built-in.o: In function `ab8500_rtc_set_alarm':
   drivers/rtc/rtc-ab8500.c:263: undefined reference to `__aeabi_uldivmod'

vim +299 drivers/rtc/rtc-ab8500.c

45a9f91a Benjamin Gaignard 2017-06-20  293  	secs = rtc_tm_to_time64(&alarm->time);
25d053cf Alexandre Torgue  2013-07-03  294  
25d053cf Alexandre Torgue  2013-07-03  295  	/*
25d053cf Alexandre Torgue  2013-07-03  296  	 * Convert it to the number of seconds since 01-01-2000 00:00:00
25d053cf Alexandre Torgue  2013-07-03  297  	 */
25d053cf Alexandre Torgue  2013-07-03  298  	secs -= get_elapsed_seconds(AB8500_RTC_EPOCH);
25d053cf Alexandre Torgue  2013-07-03 @299  	mins = secs / 60;
25d053cf Alexandre Torgue  2013-07-03  300  
25d053cf Alexandre Torgue  2013-07-03  301  	buf[3] = secs % 60;
25d053cf Alexandre Torgue  2013-07-03  302  	buf[2] = mins & 0xFF;

:::::: The code at line 299 was first introduced by commit
:::::: 25d053cf1040e6430fff679854b3710edb0b7fee drivers/rtc/rtc-ab8500.c: add second resolution to rtc driver

:::::: TO: Alexandre Torgue <alexandre.torgue@st.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 22400 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170621/a1528dd6/attachment-0001.gz>
