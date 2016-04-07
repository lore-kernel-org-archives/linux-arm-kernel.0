From: lkp@intel.com (kbuild test robot)
Date: Thu, 7 Apr 2016 22:59:02 +0800
Subject: [LINUX PATCH v2 2/3] mtd:m25p80: Assigned number of dummy cycles
 to dummy_cycles.
In-Reply-To: <1460039969-9835-2-git-send-email-lakshmis@xilinx.com>
Message-ID: <201604072216.DexSMTuF%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi L,

[auto build test ERROR on spi/for-next]
[also build test ERROR on v4.6-rc2 next-20160407]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/P-L-Sai-Krishna/spi-Added-dummy_cycle-entry-in-the-spi_transfer-structure/20160407-225040
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi for-next
config: x86_64-randconfig-x014-201614 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/mtd/devices/m25p80.c: In function 'm25p80_read':
>> drivers/mtd/devices/m25p80.c:142:6: error: 'struct spi_transfer' has no member named 'dummy'
     t[0].dummy = nor->read_dummy;
         ^

vim +142 drivers/mtd/devices/m25p80.c

   136	
   137		flash->command[0] = nor->read_opcode;
   138		m25p_addr2cmd(nor, from, flash->command);
   139	
   140		t[0].tx_buf = flash->command;
   141		t[0].len = m25p_cmdsz(nor) + dummy;
 > 142		t[0].dummy = nor->read_dummy;
   143		spi_message_add_tail(&t[0], &m);
   144	
   145		t[1].rx_buf = buf;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 24963 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160407/f1f74f04/attachment-0001.obj>
