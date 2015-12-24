From: lkp@intel.com (kbuild test robot)
Date: Thu, 24 Dec 2015 21:03:47 +0800
Subject: [PATCH v4 2/5] PCI: Handle ACPI companion and domain number
In-Reply-To: <1450958252-29892-3-git-send-email-jchandra@broadcom.com>
Message-ID: <201512242134.s2jPHdrw%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
Hi Jayachandran,

[auto build test ERROR on pm/linux-next]
[also build test ERROR on v4.4-rc6 next-20151223]
[cannot apply to pci/next]

url:    https://github.com/0day-ci/linux/commits/Jayachandran-C/ACPI-based-PCI-support-for-arm64/20151224-193703
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: arm-imx_v6_v7_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/pci/pci.c: In function 'pci_bus_assign_domain_nr':
>> drivers/pci/pci.c:4789:23: error: dereferencing pointer to incomplete type
       bus->domain_nr = ci->root->segment;
                          ^

vim +4789 drivers/pci/pci.c

  4783		 */
  4784		if (!parent || !parent->of_node) {
  4785			struct acpi_pci_root_info *ci;
  4786	
  4787			ci = acpi_pci_sysdata_to_root_info(bus->sysdata);
  4788			if (ci)
> 4789				bus->domain_nr = ci->root->segment;
  4790			return;
  4791		}
  4792	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 27221 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151224/fbd897bb/attachment-0001.obj>
