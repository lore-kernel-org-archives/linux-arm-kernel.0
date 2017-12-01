From: lkp@intel.com (kbuild test robot)
Date: Fri, 1 Dec 2017 22:41:32 +0800
Subject: [alsa-devel] [PATCH v5 04/13] IIO: inkern: API for manipulating
 channel attributes
In-Reply-To: <1511881557-28596-5-git-send-email-arnaud.pouliquen@st.com>
References: <1511881557-28596-5-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <201712012249.FyPqrq4w%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on iio/togreg]
[also build test WARNING on v4.15-rc1 next-20171201]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Arnaud-Pouliquen/Add-STM32-DFSDM-support/20171201-215409
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: xtensa-allyesconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All warnings (new ones prefixed by >>):

   In file included from drivers/iio//adc/envelope-detector.c:38:0:
>> include/linux/iio/consumer.h:228:20: warning: 'enum iio_chan_info_enum' declared inside parameter list
        int val2, enum iio_chan_info_enum attribute);
                       ^
>> include/linux/iio/consumer.h:228:20: warning: its scope is only this definition or declaration, which is probably not what you want
   include/linux/iio/consumer.h:242:27: warning: 'enum iio_chan_info_enum' declared inside parameter list
              int *val2, enum iio_chan_info_enum attribute);
                              ^

vim +228 include/linux/iio/consumer.h

   217	
   218	/**
   219	 * iio_write_channel_attribute() - Write values to the device attribute.
   220	 * @chan:	The channel being queried.
   221	 * @val:	Value being written.
   222	 * @val2:	Value being written.val2 use depends on attribute type.
   223	 * @attribute:	info attribute to be read.
   224	 *
   225	 * Returns an error code or 0.
   226	 */
   227	int iio_write_channel_attribute(struct iio_channel *chan, int val,
 > 228					int val2, enum iio_chan_info_enum attribute);
   229	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 51640 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171201/fc1aaf8e/attachment-0001.gz>
