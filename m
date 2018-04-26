From: lkp@intel.com (kbuild test robot)
Date: Thu, 26 Apr 2018 12:27:14 +0800
Subject: [PATCH 05/11] platform: use a dedicated list_head for early
 devices
In-Reply-To: <20180424173051.15099-6-brgl@bgdev.pl>
References: <20180424173051.15099-6-brgl@bgdev.pl>
Message-ID: <201804261118.MiRNu6Uc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.17-rc2]
[cannot apply to next-20180424]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/platform-device-tree-support-for-early-platform-drivers/20180426-003135
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'rx_stats_avg' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'rx_stats_avg.signal' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'rx_stats_avg.chain_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'status_stats.filtered' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'status_stats.retry_failed' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'status_stats.retry_count' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'status_stats.lost_packets' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'status_stats.last_tdls_pkt_time' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'status_stats.msdu_retries' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'status_stats.msdu_failed' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'status_stats.last_ack' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'status_stats.last_ack_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'status_stats.ack_signal_filled' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'tx_stats.packets' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'tx_stats.bytes' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'tx_stats.last_rate' not described in 'sta_info'
   net/mac80211/sta_info.h:586: warning: Function parameter or member 'tx_stats.msdu' not described in 'sta_info'
   kernel/sched/fair.c:3731: warning: Function parameter or member 'flags' not described in 'attach_entity_load_avg'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_excl.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_excl.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_excl.active' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_shared.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_shared.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_shared.active' not described in 'dma_buf'
   include/linux/dma-fence-array.h:54: warning: Function parameter or member 'work' not described in 'dma_fence_array'
   Error: Cannot open file drivers/base/firmware_class.c
   WARNING: kernel-doc 'scripts/kernel-doc -rst -enable-lineno -function request_firmware drivers/base/firmware_class.c' failed with return code 1
   Error: Cannot open file drivers/base/firmware_class.c
   WARNING: kernel-doc 'scripts/kernel-doc -rst -enable-lineno -function request_firmware_direct drivers/base/firmware_class.c' failed with return code 1
   Error: Cannot open file drivers/base/firmware_class.c
   WARNING: kernel-doc 'scripts/kernel-doc -rst -enable-lineno -function request_firmware_into_buf drivers/base/firmware_class.c' failed with return code 1
   Error: Cannot open file drivers/base/firmware_class.c
   WARNING: kernel-doc 'scripts/kernel-doc -rst -enable-lineno -function request_firmware_nowait drivers/base/firmware_class.c' failed with return code 1
   Error: Cannot open file drivers/base/firmware_class.c
   WARNING: kernel-doc 'scripts/kernel-doc -rst -enable-lineno -function firmware_request_cache drivers/base/firmware_class.c' failed with return code 1
   include/linux/gpio/driver.h:142: warning: Function parameter or member 'request_key' not described in 'gpio_irq_chip'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.sign' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.realbits' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.storagebits' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.shift' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.repeat' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.endianness' not described in 'iio_chan_spec'
   include/linux/iio/hw-consumer.h:1: warning: no structured comments found
>> include/linux/device.h:998: warning: Function parameter or member 'early_dev_head' not described in 'device'
   Error: Cannot open file drivers/base/firmware_class.c
   Error: Cannot open file drivers/base/firmware_class.c
   WARNING: kernel-doc 'scripts/kernel-doc -rst -enable-lineno -export drivers/base/firmware_class.c' failed with return code 2
   include/linux/input/sparse-keymap.h:46: warning: Function parameter or member 'sw' not described in 'key_entry'
   include/linux/mtd/rawnand.h:752: warning: Function parameter or member 'timings.sdr' not described in 'nand_data_interface'
   include/linux/mtd/rawnand.h:817: warning: Function parameter or member 'buf' not described in 'nand_op_data_instr'
   include/linux/mtd/rawnand.h:817: warning: Function parameter or member 'buf.in' not described in 'nand_op_data_instr'
   include/linux/mtd/rawnand.h:817: warning: Function parameter or member 'buf.out' not described in 'nand_op_data_instr'
   include/linux/mtd/rawnand.h:863: warning: Function parameter or member 'ctx' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:863: warning: Function parameter or member 'ctx.cmd' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:863: warning: Function parameter or member 'ctx.addr' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:863: warning: Function parameter or member 'ctx.data' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:863: warning: Function parameter or member 'ctx.waitrdy' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:1010: warning: Function parameter or member 'ctx' not described in 'nand_op_parser_pattern_elem'
   include/linux/mtd/rawnand.h:1010: warning: Function parameter or member 'ctx.addr' not described in 'nand_op_parser_pattern_elem'
   include/linux/mtd/rawnand.h:1010: warning: Function parameter or member 'ctx.data' not described in 'nand_op_parser_pattern_elem'
   include/linux/mtd/rawnand.h:1313: warning: Function parameter or member 'manufacturer.desc' not described in 'nand_chip'
   include/linux/mtd/rawnand.h:1313: warning: Function parameter or member 'manufacturer.priv' not described in 'nand_chip'
   include/linux/regulator/driver.h:222: warning: Function parameter or member 'resume_early' not described in 'regulator_ops'
   drivers/regulator/core.c:4306: warning: Excess function parameter 'state' description in 'regulator_suspend_late'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw0' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw1' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw2' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw3' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.eadm' not described in 'irb'
   drivers/usb/typec/mux.c:186: warning: Function parameter or member 'mux' not described in 'typec_mux_unregister'
   drivers/usb/typec/mux.c:186: warning: Excess function parameter 'sw' description in 'typec_mux_unregister'

vim +998 include/linux/device.h

^1da177e Linus Torvalds 2005-04-16 @998  

:::::: The code at line 998 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6353 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180426/2ee01a96/attachment.gz>
