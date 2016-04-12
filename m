From: lkp@intel.com (kbuild test robot)
Date: Tue, 12 Apr 2016 09:38:09 +0800
Subject: [PATCH v2 4/4] ACPI: PCI: Add generic PCI host controller
In-Reply-To: <1460414707-19153-5-git-send-email-jchandra@broadcom.com>
Message-ID: <201604120947.xqHH8wsY%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jayachandran,

[auto build test ERROR on pci/next]
[also build test ERROR on v4.6-rc3 next-20160411]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Jayachandran-C/ACPI-based-PCI-host-driver-with-generic-ECAM/20160412-064853
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: arm64-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> drivers/xen/pci.c:31:25: fatal error: asm/pci_x86.h: No such file or directory
    #include <asm/pci_x86.h>
                            ^
   compilation terminated.

vim +31 drivers/xen/pci.c

e28c31a9 Weidong Han           2010-10-27  15   * Place - Suite 330, Boston, MA 02111-1307 USA.
e28c31a9 Weidong Han           2010-10-27  16   *
e28c31a9 Weidong Han           2010-10-27  17   * Author: Weidong Han <weidong.han@intel.com>
e28c31a9 Weidong Han           2010-10-27  18   */
e28c31a9 Weidong Han           2010-10-27  19  
e28c31a9 Weidong Han           2010-10-27  20  #include <linux/pci.h>
55e901fc Jan Beulich           2011-09-22  21  #include <linux/acpi.h>
0b97b03d Ross Lagerwall        2015-04-09  22  #include <linux/pci-acpi.h>
e28c31a9 Weidong Han           2010-10-27  23  #include <xen/xen.h>
e28c31a9 Weidong Han           2010-10-27  24  #include <xen/interface/physdev.h>
e28c31a9 Weidong Han           2010-10-27  25  #include <xen/interface/xen.h>
e28c31a9 Weidong Han           2010-10-27  26  
e28c31a9 Weidong Han           2010-10-27  27  #include <asm/xen/hypervisor.h>
e28c31a9 Weidong Han           2010-10-27  28  #include <asm/xen/hypercall.h>
e28c31a9 Weidong Han           2010-10-27  29  #include "../pci/pci.h"
b7ef4a6d Ben Hutchings         2013-12-31  30  #ifdef CONFIG_PCI_MMCONFIG
8deb3eb1 Konrad Rzeszutek Wilk 2013-10-25 @31  #include <asm/pci_x86.h>
b7ef4a6d Ben Hutchings         2013-12-31  32  #endif
e28c31a9 Weidong Han           2010-10-27  33  
55e901fc Jan Beulich           2011-09-22  34  static bool __read_mostly pci_seg_supported = true;
55e901fc Jan Beulich           2011-09-22  35  
e28c31a9 Weidong Han           2010-10-27  36  static int xen_add_device(struct device *dev)
e28c31a9 Weidong Han           2010-10-27  37  {
e28c31a9 Weidong Han           2010-10-27  38  	int r;
e28c31a9 Weidong Han           2010-10-27  39  	struct pci_dev *pci_dev = to_pci_dev(dev);

:::::: The code at line 31 was first introduced by commit
:::::: 8deb3eb1461e4cb136c88d03ec5a6729ccf2f933 xen/mcfg: Call PHYSDEVOP_pci_mmcfg_reserved for MCFG areas.

:::::: TO: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
:::::: CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 49553 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160412/ae837dc6/attachment-0001.obj>
