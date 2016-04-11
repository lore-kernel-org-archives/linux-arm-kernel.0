From: lkp@intel.com (kbuild test robot)
Date: Mon, 11 Apr 2016 16:08:14 +0800
Subject: [PATCH] Axi-usb: Add support for 64-bit addressing.
In-Reply-To: <1460360506-14692-1-git-send-email-navam@xilinx.com>
Message-ID: <201604111626.g2x2SCHX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nava,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.6-rc3 next-20160411]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Nava-kishore-Manne/Axi-usb-Add-support-for-64-bit-addressing/20160411-154657
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: i386-randconfig-x015-201615 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/usb/gadget/udc/udc-xilinx.c: In function 'xudc_write64':
>> drivers/usb/gadget/udc/udc-xilinx.c:236:2: error: implicit declaration of function 'writeq' [-Werror=implicit-function-declaration]
     writeq(val, addr + offset);
     ^
   cc1: some warnings being treated as errors

vim +/writeq +236 drivers/usb/gadget/udc/udc-xilinx.c

   230	 * @offset: register offset
   231	 * @val: data to be written
   232	 **/
   233	static void xudc_write64(void __iomem *addr, u32 offset, u64 val)
   234	{
   235	#if defined(CONFIG_PHYS_ADDR_T_64BIT)
 > 236		writeq(val, addr + offset);
   237	#endif
   238	}
   239	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 24377 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160411/624cd719/attachment-0001.obj>
