From: lkp@intel.com (kbuild test robot)
Date: Mon, 8 May 2017 03:08:24 +0800
Subject: [PATCH v5 3/3] PCI/of fix of_dma_get_range; get PCI specific
 dma-ranges
In-Reply-To: <1493992827-1553-4-git-send-email-oza.oza@broadcom.com>
Message-ID: <201705080258.8tzPFTzu%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oza,

[auto build test ERROR on v4.9-rc8]
[cannot apply to glikely/devicetree/next iommu/next next-20170505]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Oza-Pawandeep/OF-PCI-address-PCI-inbound-memory-limitations/20170508-004625
config: arm-arm67 (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers//of/address.c: In function 'of_bus_pci_get_dma_ranges':
>> drivers//of/address.c:212:2: error: implicit declaration of function 'pci_free_resource_list' [-Werror=implicit-function-declaration]
     pci_free_resource_list(&res);
     ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/pci_free_resource_list +212 drivers//of/address.c

   206				*dma_addr = res_dma->start - window->offset;
   207				*paddr = res_dma->start;
   208				*size = resource_size(res_dma);
   209				}
   210			}
   211		}
 > 212		pci_free_resource_list(&res);
   213	
   214		/*
   215		 * return the largest possible size,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30170 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170508/6c494a66/attachment-0001.gz>
