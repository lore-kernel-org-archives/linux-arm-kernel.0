From: lkp@intel.com (kbuild test robot)
Date: Tue, 16 May 2017 15:41:44 +0800
Subject: [PATCH v6 3/3] PCI/of fix of_dma_get_range; get PCI specific
 dma-ranges
In-Reply-To: <1494912127-12890-4-git-send-email-oza.oza@broadcom.com>
Message-ID: <201705161534.hBTKNcfz%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oza,

[auto build test ERROR on v4.9-rc8]
[cannot apply to next-20170516]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Oza-Pawandeep/of-pci-dma-fix-DMA-configuration-for-PCI-masters/20170516-141222
config: c6x-evmc6678_defconfig (attached as .config)
compiler: c6x-elf-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=c6x 

All errors (new ones prefixed by >>):

>> drivers//of/address.c:580:21: error: 'of_bus_isa_get_dma_ranges' undeclared here (not in a function)
      .get_dma_ranges = of_bus_isa_get_dma_ranges,
                        ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers//of/address.c:591:21: error: 'of_bus_default_get_dma_ranges' undeclared here (not in a function)
      .get_dma_ranges = of_bus_default_get_dma_ranges,
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/of_bus_isa_get_dma_ranges +580 drivers//of/address.c

   574			.addresses = "reg",
   575			.match = of_bus_isa_match,
   576			.count_cells = of_bus_isa_count_cells,
   577			.map = of_bus_isa_map,
   578			.translate = of_bus_isa_translate,
   579			.get_flags = of_bus_isa_get_flags,
 > 580			.get_dma_ranges = of_bus_isa_get_dma_ranges,
   581		},
   582		/* Default */
   583		{
   584			.name = "default",
   585			.addresses = "reg",
   586			.match = NULL,
   587			.count_cells = of_bus_default_count_cells,
   588			.map = of_bus_default_map,
   589			.translate = of_bus_default_translate,
   590			.get_flags = of_bus_default_get_flags,
 > 591			.get_dma_ranges = of_bus_default_get_dma_ranges,
   592		},
   593	};
   594	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 5161 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170516/6c24fb7d/attachment-0001.gz>
