From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 28 Feb 2017 06:24:50 +0800
Subject: [nomadik:gemini 37/45] drivers/pci/host/pci-ftpci100.c:175:2: error:
 implicit declaration of function 'pr_dbg'
Message-ID: <201702280646.7TefO37f%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini
head:   b5a084bbd084caf3c47995083d03bdc847a9f445
commit: f81a2826bb2369b05cd06a97b27d9e3fbdc2150e [37/45] PCI: add driver for Faraday Technology Host Bridge
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout f81a2826bb2369b05cd06a97b27d9e3fbdc2150e
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/pci/host/pci-ftpci100.c: In function 'faraday_res_to_memcfg':
>> drivers/pci/host/pci-ftpci100.c:175:2: error: implicit declaration of function 'pr_dbg' [-Werror=implicit-function-declaration]
     pr_dbg("Translated pci base @%08x, size %08x to config %08x\n",
     ^~~~~~
   cc1: some warnings being treated as errors

vim +/pr_dbg +175 drivers/pci/host/pci-ftpci100.c

   169	
   170		/* This is probably not good */
   171		if (mem_base & ~(FARADAY_PCI_MEMBASE_MASK))
   172			pr_warn("truncated PCI memory base\n");
   173		/* Translate to bridge side address space */
   174		outval |= (mem_base & FARADAY_PCI_MEMBASE_MASK);
 > 175		pr_dbg("Translated pci base @%08x, size %08x to config %08x\n",
   176		       mem_base, mem_size, outval);
   177	
   178		*val = outval;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 60362 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170228/a2908ccf/attachment-0001.gz>
