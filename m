From: lkp@intel.com (kbuild test robot)
Date: Sun, 12 Jun 2016 17:28:23 +0800
Subject: [RESEND/PATCHv4 v4 3/3] firmware: Support loading into a
 pre-allocated buffer
In-Reply-To: <20160607164741.31849-4-stephen.boyd@linaro.org>
Message-ID: <201606121736.x3UpVTjF%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on v4.7-rc2]
[cannot apply to next-20160609]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Stephen-Boyd/firmware-Consolidate-kmap-read-write-logic/20160607-164005
config: x86_64-randconfig-v0-06121632 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   In file included from drivers/video/fbdev/metronomefb.c:33:0:
>> include/linux/firmware.h:82:1: error: expected identifier or '(' before '{' token
    {
    ^
   include/linux/firmware.h:80:19: warning: 'request_firmware_into_buf' declared 'static' but never defined [-Wunused-function]
    static inline int request_firmware_into_buf(const struct firmware **firmware_p,
                      ^~~~~~~~~~~~~~~~~~~~~~~~~

vim +82 include/linux/firmware.h

    76	{
    77		return -EINVAL;
    78	}
    79	
    80	static inline int request_firmware_into_buf(const struct firmware **firmware_p,
    81		const char *name, struct device *device, void *buf, size_t size);
  > 82	{
    83		return -EINVAL;
    84	}
    85	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 23402 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160612/becc8f69/attachment-0001.obj>
