From: tony@atomide.com (Tony Lindgren)
Date: Tue, 11 Sep 2012 11:46:06 -0700
Subject: [PATCH v6 10/10] ARM: OMAP2+: tusb6010: generic timing calculation
In-Reply-To: <20120906204354.GJ1303@atomide.com>
References: <cover.1345524670.git.afzal@ti.com>
 <bc000ac53bb1b3ae1a951bbcf372caf6336d2a19.1345524670.git.afzal@ti.com>
 <20120824194630.GU11011@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9BA589@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DC11D@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DEC85@DBDE01.ent.ti.com>
 <20120906204354.GJ1303@atomide.com>
Message-ID: <20120911184606.GN23092@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120906 13:45]:
> * Mohammed, Afzal <afzal@ti.com> [120906 00:40]:
> > Hi Tony,
> > 
> > On Mon, Sep 03, 2012 at 11:04:10, Mohammed, Afzal wrote:
> > > On Mon, Aug 27, 2012 at 14:04:44, Mohammed, Afzal wrote:
> > > > On Sat, Aug 25, 2012 at 01:16:30, Tony Lindgren wrote:
> > 
> > > > > This hangs n800 during the boot.
> > 
> > Paul reported that n800 stopped booting on OMAP baseline [1]
> > due to an mmc issue and has posted a solution [2].
> > 
> > Are you facing the same issue ?, if so, then it is not
> > due to this series.
> 
> No that's a separate issue. Your series works except for
> this patch makes thing hang.

Here are the timing changes with and without this patch from
my n800. You can just diff the two files to see some differences.

Regards,

Tony
-------------- next part --------------
GPMC CS1: cs_on     :   1 ticks,   9 ns (was   0 ticks)   9 ns
GPMC CS1: cs_rd_off :   8 ticks,  72 ns (was   5 ticks)  72 ns
GPMC CS1: cs_wr_off :   8 ticks,  72 ns (was   5 ticks)  72 ns
GPMC CS1: adv_on    :   6 ticks,  54 ns (was   0 ticks)  54 ns
GPMC CS1: adv_rd_off:   7 ticks,  63 ns (was   3 ticks)  63 ns
GPMC CS1: adv_wr_off:   7 ticks,  63 ns (was   3 ticks)  63 ns
GPMC CS1: oe_on     :   7 ticks,  63 ns (was   4 ticks)  63 ns
GPMC CS1: oe_off    :   8 ticks,  72 ns (was   5 ticks)  72 ns
GPMC CS1: we_on     :   8 ticks,  72 ns (was   4 ticks)  72 ns
GPMC CS1: we_off    :   8 ticks,  72 ns (was   5 ticks)  72 ns
GPMC CS1: rd_cycle  :   9 ticks,  82 ns (was   5 ticks)  82 ns
GPMC CS1: wr_cycle  :   9 ticks,  82 ns (was   5 ticks)  82 ns
GPMC CS1: access    :   7 ticks,  63 ns (was   5 ticks)  63 ns
GPMC CS1: page_burst_access:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS1: bus_turnaround:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS1: cycle2cycle_delay:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS1: wait_monitoring:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS1: clk_activation:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS4: cs_on     :   1 ticks,   9 ns (was   0 ticks)   9 ns
GPMC CS4: cs_rd_off :  16 ticks, 145 ns (was   7 ticks) 145 ns
GPMC CS4: cs_wr_off :  16 ticks, 145 ns (was   7 ticks) 145 ns
GPMC CS4: adv_on    :   6 ticks,  54 ns (was   2 ticks)  54 ns
GPMC CS4: adv_rd_off:   7 ticks,  63 ns (was   4 ticks)  63 ns
GPMC CS4: adv_wr_off:   7 ticks,  63 ns (was   4 ticks)  63 ns
GPMC CS4: oe_on     :  10 ticks,  91 ns (was   5 ticks)  91 ns
GPMC CS4: oe_off    :  16 ticks, 145 ns (was   7 ticks) 145 ns
GPMC CS4: we_on     :  10 ticks,  91 ns (was   5 ticks)  91 ns
GPMC CS4: we_off    :  16 ticks, 145 ns (was   6 ticks) 145 ns
GPMC CS4: rd_cycle  :  17 ticks, 154 ns (was   8 ticks) 154 ns
GPMC CS4: wr_cycle  :  17 ticks, 154 ns (was   8 ticks) 154 ns
GPMC CS4: access    :  15 ticks, 136 ns (was   6 ticks) 136 ns
GPMC CS4: page_burst_access:   2 ticks,  18 ns (was   2 ticks)  18 ns
GPMC CS4: bus_turnaround:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS4: cycle2cycle_delay:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS4: wait_monitoring:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS4: clk_activation:   1 ticks,   9 ns (was   0 ticks)   9 ns
GPMC CS4 CLK period is 18 ns (div 2)
TUSB 6010
...
OneNAND driver initializing
GPMC CS0: cs_on     :   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS0: cs_rd_off :  10 ticks,  91 ns (was  12 ticks)  91 ns
GPMC CS0: cs_wr_off :  12 ticks, 109 ns (was   9 ticks) 109 ns
GPMC CS0: adv_on    :   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS0: adv_rd_off:   2 ticks,  18 ns (was   2 ticks)  18 ns
GPMC CS0: adv_wr_off:   2 ticks,  18 ns (was   2 ticks)  18 ns
GPMC CS0: oe_on     :   3 ticks,  27 ns (was   2 ticks)  27 ns
GPMC CS0: oe_off    :  10 ticks,  91 ns (was  12 ticks)  91 ns
GPMC CS0: we_on     :   3 ticks,  27 ns (was   3 ticks)  27 ns
GPMC CS0: we_off    :   8 ticks,  72 ns (was   8 ticks)  72 ns
GPMC CS0: rd_cycle  :  13 ticks, 118 ns (was  13 ticks) 118 ns
GPMC CS0: wr_cycle  :  15 ticks, 136 ns (was  10 ticks) 136 ns
GPMC CS0: access    :   9 ticks,  82 ns (was  11 ticks)  82 ns
GPMC CS0: page_burst_access:   0 ticks,   0 ns (was   2 ticks)   0 ns
GPMC CS0: bus_turnaround:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS0: cycle2cycle_delay:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS0: wait_monitoring:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS0: clk_activation:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS0: cs_on     :   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS0: cs_rd_off :  14 ticks, 127 ns (was  10 ticks) 127 ns
GPMC CS0: cs_wr_off :  12 ticks, 109 ns (was  12 ticks) 109 ns
GPMC CS0: adv_on    :   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS0: adv_rd_off:   2 ticks,  18 ns (was   2 ticks)  18 ns
GPMC CS0: adv_wr_off:   2 ticks,  18 ns (was   2 ticks)  18 ns
GPMC CS0: oe_on     :   3 ticks,  27 ns (was   3 ticks)  27 ns
GPMC CS0: oe_off    :  14 ticks, 127 ns (was  10 ticks) 127 ns
GPMC CS0: we_on     :   3 ticks,  27 ns (was   3 ticks)  27 ns
GPMC CS0: we_off    :   8 ticks,  72 ns (was   8 ticks)  72 ns
GPMC CS0: rd_cycle  :  16 ticks, 145 ns (was  13 ticks) 145 ns
GPMC CS0: wr_cycle  :  15 ticks, 136 ns (was  15 ticks) 136 ns
GPMC CS0: access    :  13 ticks, 118 ns (was   9 ticks) 118 ns
GPMC CS0: page_burst_access:   3 ticks,  27 ns (was   0 ticks)  27 ns
GPMC CS0: bus_turnaround:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS0: cycle2cycle_delay:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS0: wait_monitoring:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS0: clk_activation:   1 ticks,   9 ns (was   0 ticks)   9 ns
GPMC CS0 CLK period is 27 ns (div 3)
omap2-onenand omap2-onenand: initializing on CS0, phys base 0x04000000, virtual base c88c0000, freq 54 MHz
OneNAND Manufacturer: Samsung (0xec)
Muxed OneNAND(DDP) 256MB 1.8V 16-bit (0x48)
OneNAND version = 0x0011
Chip support all block unlock
onenand_wait: controller error! state 15 ctrl 0x0400 intr 0x8000
Scanning device for bad blocks
Creating 5 MTD partitions on "omap2-onenand":
0x000000000000-0x000000020000 : "bootloader"
0x000000020000-0x000000080000 : "config"
0x000000080000-0x000000280000 : "kernel"
0x000000280000-0x000000680000 : "initfs"
0x000000680000-0x000010000000 : "rootfs"
omap-dma-engine omap-dma-engine: allocating channel for 44
omap-dma-engine omap-dma-engine: allocating channel for 43

-------------- next part --------------
GPMC CS1: cs_on     :   1 ticks,   9 ns (was   0 ticks)   8 ns
GPMC CS1: cs_rd_off :   9 ticks,  82 ns (was   5 ticks)  82 ns
GPMC CS1: cs_wr_off :   9 ticks,  82 ns (was   5 ticks)  82 ns
GPMC CS1: adv_on    :   6 ticks,  54 ns (was   0 ticks)  48 ns
GPMC CS1: adv_rd_off:   7 ticks,  63 ns (was   3 ticks)  63 ns
GPMC CS1: adv_wr_off:   7 ticks,  63 ns (was   3 ticks)  63 ns
GPMC CS1: oe_on     :   7 ticks,  63 ns (was   4 ticks)  63 ns
GPMC CS1: oe_off    :   9 ticks,  82 ns (was   5 ticks)  82 ns
GPMC CS1: we_on     :   8 ticks,  72 ns (was   4 ticks)  72 ns
GPMC CS1: we_off    :   9 ticks,  82 ns (was   5 ticks)  82 ns
GPMC CS1: rd_cycle  :  10 ticks,  91 ns (was   5 ticks)  91 ns
GPMC CS1: wr_cycle  :  10 ticks,  91 ns (was   5 ticks)  91 ns
GPMC CS1: access    :   8 ticks,  72 ns (was   5 ticks)  72 ns
GPMC CS1: page_burst_access:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS1: bus_turnaround:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS1: cycle2cycle_delay:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS1: wait_monitoring:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS1: clk_activation:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS4: cs_on     :   1 ticks,   9 ns (was   0 ticks)   8 ns
GPMC CS4: cs_rd_off :  16 ticks, 145 ns (was   7 ticks) 145 ns
GPMC CS4: cs_wr_off :  16 ticks, 145 ns (was   7 ticks) 144 ns
GPMC CS4: adv_on    :   6 ticks,  54 ns (was   2 ticks)  48 ns
GPMC CS4: adv_rd_off:   7 ticks,  63 ns (was   4 ticks)  63 ns
GPMC CS4: adv_wr_off:   7 ticks,  63 ns (was   4 ticks)  63 ns
GPMC CS4: oe_on     :  10 ticks,  91 ns (was   5 ticks)  90 ns
GPMC CS4: oe_off    :  16 ticks, 145 ns (was   7 ticks) 145 ns
GPMC CS4: we_on     :  10 ticks,  91 ns (was   5 ticks)  90 ns
GPMC CS4: we_off    :  16 ticks, 145 ns (was   6 ticks) 144 ns
GPMC CS4: rd_cycle  :  17 ticks, 154 ns (was   8 ticks) 154 ns
GPMC CS4: wr_cycle  :  17 ticks, 154 ns (was   8 ticks) 154 ns
GPMC CS4: access    :  15 ticks, 136 ns (was   6 ticks) 135 ns
GPMC CS4: page_burst_access:   2 ticks,  18 ns (was   2 ticks)  18 ns
GPMC CS4: bus_turnaround:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS4: cycle2cycle_delay:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS4: wait_monitoring:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS4: clk_activation:   1 ticks,   9 ns (was   0 ticks)   9 ns
GPMC CS4 CLK period is 18 ns (div 2)
TUSB 6010
...

OneNAND driver initializing
GPMC CS0: cs_on     :   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS0: cs_rd_off :  10 ticks,  91 ns (was  12 ticks)  91 ns
GPMC CS0: cs_wr_off :  12 ticks, 109 ns (was   9 ticks) 108 ns
GPMC CS0: adv_on    :   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS0: adv_rd_off:   2 ticks,  18 ns (was   2 ticks)  18 ns
GPMC CS0: adv_wr_off:   2 ticks,  18 ns (was   2 ticks)  18 ns
GPMC CS0: oe_on     :   3 ticks,  27 ns (was   2 ticks)  27 ns
GPMC CS0: oe_off    :  10 ticks,  91 ns (was  12 ticks)  91 ns
GPMC CS0: we_on     :   3 ticks,  27 ns (was   3 ticks)  27 ns
GPMC CS0: we_off    :   8 ticks,  72 ns (was   8 ticks)  72 ns
GPMC CS0: rd_cycle  :  13 ticks, 118 ns (was  13 ticks) 118 ns
GPMC CS0: wr_cycle  :  15 ticks, 136 ns (was  10 ticks) 135 ns
GPMC CS0: access    :   9 ticks,  82 ns (was  11 ticks)  82 ns
GPMC CS0: page_burst_access:   0 ticks,   0 ns (was   2 ticks)   0 ns
GPMC CS0: bus_turnaround:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS0: cycle2cycle_delay:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS0: wait_monitoring:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS0: clk_activation:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS0: cs_on     :   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS0: cs_rd_off :  14 ticks, 127 ns (was  10 ticks) 127 ns
GPMC CS0: cs_wr_off :  12 ticks, 109 ns (was  12 ticks) 108 ns
GPMC CS0: adv_on    :   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS0: adv_rd_off:   2 ticks,  18 ns (was   2 ticks)  18 ns
GPMC CS0: adv_wr_off:   2 ticks,  18 ns (was   2 ticks)  18 ns
GPMC CS0: oe_on     :   3 ticks,  27 ns (was   3 ticks)  27 ns
GPMC CS0: oe_off    :  14 ticks, 127 ns (was  10 ticks) 127 ns
GPMC CS0: we_on     :   3 ticks,  27 ns (was   3 ticks)  27 ns
GPMC CS0: we_off    :   8 ticks,  72 ns (was   8 ticks)  72 ns
GPMC CS0: rd_cycle  :  16 ticks, 145 ns (was  13 ticks) 145 ns
GPMC CS0: wr_cycle  :  15 ticks, 136 ns (was  15 ticks) 135 ns
GPMC CS0: access    :  13 ticks, 118 ns (was   9 ticks) 118 ns
GPMC CS0: page_burst_access:   3 ticks,  27 ns (was   0 ticks)  27 ns
GPMC CS0: bus_turnaround:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS0: cycle2cycle_delay:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS0: wait_monitoring:   0 ticks,   0 ns (was   0 ticks)   0 ns
GPMC CS0: clk_activation:   1 ticks,   9 ns (was   0 ticks)   9 ns
GPMC CS0 CLK period is 27 ns (div 3)
omap2-onenand omap2-onenand: initializing on CS0, phys base 0x04000000, virtual base c88c0000, freq 54 MHz
OneNAND Manufacturer: Samsung (0xec)
Muxed OneNAND(DDP) 256MB 1.8V 16-bit (0x48)
OneNAND version = 0x0011
Chip support all block unlock
onenand_wait: controller error! state 15 ctrl 0x0400 intr 0x8000
Scanning device for bad blocks
Creating 5 MTD partitions on "omap2-onenand":
0x000000000000-0x000000020000 : "bootloader"
0x000000020000-0x000000080000 : "config"
0x000000080000-0x000000280000 : "kernel"
0x000000280000-0x000000680000 : "initfs"
0x000000680000-0x000010000000 : "rootfs"
omap-dma-engine omap-dma-engine: allocating channel for 44
omap-dma-engine omap-dma-engine: allocating channel for 43
