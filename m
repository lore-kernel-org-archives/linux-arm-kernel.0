From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 25 Jan 2017 15:53:25 +0800
Subject: [xlnx:master 2265/2625] include/trace/events/bcache.h:30:3: error:
 implicit declaration of function 'blk_fill_rwbs'
Message-ID: <201701251506.O2fOsCyn%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   4dcc2058b8620d77b8be9940626b339d848c0dfc
commit: 6459d1f532346096aa65a364ad28c81a4aed5c65 [2265/2625] Merge tag 'v4.4' into master
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 6459d1f532346096aa65a364ad28c81a4aed5c65
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All error/warnings (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:90:0,
                    from include/trace/events/bcache.h:482,
                    from drivers/md/bcache/trace.c:8:
   include/trace/events/bcache.h: In function 'trace_event_raw_event_bcache_request':
>> include/trace/events/bcache.h:30:3: error: implicit declaration of function 'blk_fill_rwbs' [-Werror=implicit-function-declaration]
      blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_iter.bi_size);
      ^
   include/trace/trace_events.h:683:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
>> include/trace/events/bcache.h:23:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from arch/ia64/include/asm/smp.h:20:0,
                    from include/linux/smp.h:59,
                    from include/linux/topology.h:33,
                    from include/linux/gfp.h:8,
                    from include/linux/kmod.h:22,
                    from include/linux/module.h:13,
                    from drivers/gpio/gpio-xilinx.c:18:
   drivers/gpio/gpio-xilinx.c: In function 'xgpio_irq_mask':
   arch/ia64/include/asm/io.h:394:30: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define writel(v,a) __writel((v), (a))
                                 ^
>> arch/ia64/include/asm/io.h:402:22: note: in expansion of macro 'writel'
    #define __raw_writel writel
                         ^~~~~~
>> drivers/gpio/gpio-xilinx.c:48:38: note: in expansion of macro '__raw_writel'
    # define xgpio_writereg(offset, val) __raw_writel(val, offset)
                                         ^~~~~~~~~~~~
>> drivers/gpio/gpio-xilinx.c:260:4: note: in expansion of macro 'xgpio_writereg'
       xgpio_writereg(mm_gc->regs + XGPIO_GIER_OFFSET,
       ^~~~~~~~~~~~~~
   drivers/gpio/gpio-xilinx.c: In function 'xgpio_irq_setup':
   drivers/gpio/gpio-xilinx.c:423:37: warning: passing argument 2 of 'irq_set_chained_handler' from incompatible pointer type [-Wincompatible-pointer-types]
     irq_set_chained_handler(res.start, xgpio_irqhandler);
                                        ^~~~~~~~~~~~~~~~
   In file included from include/linux/of_irq.h:6:0,
                    from drivers/gpio/gpio-xilinx.c:20:
   include/linux/irq.h:537:1: note: expected 'irq_flow_handler_t {aka void (*)(struct irq_desc *)}' but argument is of type 'void (*)(unsigned int,  struct irq_desc *)'
    irq_set_chained_handler(unsigned int irq, irq_flow_handler_t handle)
    ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/trace/define_trace.h:90:0,
                    from include/trace/events/block.h:673,
                    from block/blk-core.c:38:
   include/trace/events/block.h: In function 'trace_event_get_offsets_block_rq_with_error':
>> include/trace/events/block.h:76:31: error: implicit declaration of function 'blk_cmd_buf_len' [-Werror=implicit-function-declaration]
      __dynamic_array( char, cmd, blk_cmd_buf_len(rq) )
                                  ^
   include/trace/trace_events.h:495:2: note: in definition of macro 'DECLARE_EVENT_CLASS'
     tstruct;       \
     ^~~~~~~
>> include/trace/events/block.h:70:2: note: in expansion of macro 'TP_STRUCT__entry'
     TP_STRUCT__entry(
     ^~~~~~~~~~~~~~~~
>> include/trace/events/block.h:76:3: note: in expansion of macro '__dynamic_array'
      __dynamic_array( char, cmd, blk_cmd_buf_len(rq) )
      ^~~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:90:0,
                    from include/trace/events/block.h:673,
                    from block/blk-core.c:38:
   include/trace/events/block.h: In function 'trace_event_raw_event_block_rq_with_error':
>> include/trace/events/block.h:87:3: error: implicit declaration of function 'blk_fill_rwbs' [-Werror=implicit-function-declaration]
      blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, blk_rq_bytes(rq));
      ^
   include/trace/trace_events.h:683:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
>> include/trace/events/block.h:79:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
>> include/trace/events/block.h:88:3: error: implicit declaration of function 'blk_dump_cmd' [-Werror=implicit-function-declaration]
      blk_dump_cmd(__get_str(cmd), rq);
      ^
   include/trace/trace_events.h:683:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
>> include/trace/events/block.h:79:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/blk_fill_rwbs +30 include/trace/events/bcache.h

cafe5635 Kent Overstreet 2013-03-23  17  		__field(sector_t,	sector			)
cafe5635 Kent Overstreet 2013-03-23  18  		__field(dev_t,		orig_sector		)
cafe5635 Kent Overstreet 2013-03-23  19  		__field(unsigned int,	nr_sector		)
cafe5635 Kent Overstreet 2013-03-23  20  		__array(char,		rwbs,	6		)
cafe5635 Kent Overstreet 2013-03-23  21  	),
cafe5635 Kent Overstreet 2013-03-23  22  
cafe5635 Kent Overstreet 2013-03-23 @23  	TP_fast_assign(
cafe5635 Kent Overstreet 2013-03-23  24  		__entry->dev		= bio->bi_bdev->bd_dev;
220bb38c Kent Overstreet 2013-09-10  25  		__entry->orig_major	= d->disk->major;
220bb38c Kent Overstreet 2013-09-10  26  		__entry->orig_minor	= d->disk->first_minor;
4f024f37 Kent Overstreet 2013-10-11  27  		__entry->sector		= bio->bi_iter.bi_sector;
4f024f37 Kent Overstreet 2013-10-11  28  		__entry->orig_sector	= bio->bi_iter.bi_sector - 16;
4f024f37 Kent Overstreet 2013-10-11  29  		__entry->nr_sector	= bio->bi_iter.bi_size >> 9;
4f024f37 Kent Overstreet 2013-10-11 @30  		blk_fill_rwbs(__entry->rwbs, bio->bi_rw, bio->bi_iter.bi_size);
cafe5635 Kent Overstreet 2013-03-23  31  	),
cafe5635 Kent Overstreet 2013-03-23  32  
c37511b8 Kent Overstreet 2013-04-26  33  	TP_printk("%d,%d %s %llu + %u (from %d,%d @ %llu)",

:::::: The code at line 30 was first introduced by commit
:::::: 4f024f3797c43cb4b73cd2c50cec728842d0e49e block: Abstract out bvec iterator

:::::: TO: Kent Overstreet <kmo@daterainc.com>
:::::: CC: Kent Overstreet <kmo@daterainc.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 41685 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/a3c43104/attachment-0001.gz>
