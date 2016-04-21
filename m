From: lkp@intel.com (kbuild test robot)
Date: Thu, 21 Apr 2016 13:13:28 +0800
Subject: [PATCH 2/4] net: thunderx: Add multiqset support for dataplane
 apps
In-Reply-To: <1461072812-44239-3-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <201604211331.ptfwtkIL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on net/master]
[also build test ERROR on v4.6-rc4 next-20160420]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/sunil-kovvuri-gmail-com/net-thunderx-Add-multiqset-support-for-DPDK/20160419-213640
config: x86_64-randconfig-s4-04211222 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/cavium/thunder/nic_main.c: In function 'nic_get_vf_pdev':
>> drivers/net/ethernet/cavium/thunder/nic_main.c:600:12: error: 'struct pci_dev' has no member named 'physfn'
      if (vfdev->physfn != pdev)
               ^

vim +600 drivers/net/ethernet/cavium/thunder/nic_main.c

   594		pci_read_config_word(pdev, pos + PCI_SRIOV_VF_DID, &devid);
   595	
   596		vfdev = pci_get_device(vid, devid, NULL);
   597		for (; vfdev; vfdev = pci_get_device(vid, devid, vfdev)) {
   598			if (!vfdev->is_virtfn)
   599				continue;
 > 600			if (vfdev->physfn != pdev)
   601				continue;
   602			if (vf >= vf_en)
   603				continue;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 24128 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160421/5a686ae4/attachment-0001.obj>
