From: sumeshkkn@hotmail.com (Sumesh Kaana)
Date: Sat, 28 Aug 2010 13:26:14 +0000
Subject: mmc over SPI on DM6467 based board. card not detected.
In-Reply-To: <87fwy0orsg.fsf@deeprootsystems.com>
References: <4C516634.5040804@criticallink.com>,
	<877hjd106u.fsf@deeprootsystems.com>,
	<4C7702EB.8040905@criticallink.com>,
	<8762ywrvpt.fsf@deeprootsystems.com>,
	<4C77E6BD.4000303@criticallink.com>,
	<87fwy0orsg.fsf@deeprootsystems.com>
Message-ID: <BLU124-W40A2B008B886302781867B4870@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi all,

 I am trying to mount SD-Card over SPI on our custom DM6467
board. davinci spi controller driver and mmc over spi drver are selected in the menuconfig. i am using davinci-PSP.03-XX-00-37 kernel. 
I have also edited board initialization file to probe the MMC card under SPI as below:

 

static struct spi_board_info
dm646x_spi_info[] __initconst = {

#ifdef CONFIG_MMC_SPI

       
{

               
.modalias = "mmc_spi",

               
.max_speed_hz = (750 * 1000 ),     /* max spi clock (SCK)
speed in HZ */

               
.bus_num = 0,

               
.chip_select =
0,                      
/* CS0 */

               
.mode           = SPI_MODE_0,

       
},

#endif

 


The kernel boots with following log

 

spi_davinci spi_davinci.0: DaVinci
SPI driver in EDMA mode

Using RX channel = 17 , TX channel =
16 and event queue = 3

spi_davinci spi_davinci.0:
Controller at 0xfec66800

?????

????..

mmc_spi spi0.0: ASSUMING SPI bus
stays unshared!

mmc_spi spi0.0: ASSUMING 3.2-3.4 V
slot power

mmc0: clock 0Hz busmode 0 powermode
0 cs 0 Vdd 0 width 0 timing 0

mmc_spi spi0.0: SD/MMC host mmc0, no
WP, no poweroff

mmc0: clock 0Hz busmode 2 powermode
1 cs 1 Vdd 21 width 0 timing 0

mmc_spi spi0.0: mmc_spi: power up
(21)

 

mmc0: Minimum clock frequency too
high for identification mode

mmc0: clock 750000Hz busmode 2
powermode 2 cs 1 Vdd 21 width 0 timing 0

mmc_spi spi0.0: mmc_spi: power on
(21)

mmc_spi spi0.0: can't change
chip-select polarity 1

mmc0: starting CMD52 arg 80000c08
flags 00000015

mmc_spi spi0.0: bogus command

Backtrace: 

[<c002a7d0>]
(dump_backtrace+0x0/0x114) from [<c023f5e4>] (dump_stack+0x18/0x1c)

 r7:ce0bf400 r6:ce0bf400
r5:ce0bf5c0 r4:00000000

[<c023f5cc>]
(dump_stack+0x0/0x1c) from [<c01af3f0>] (mmc_spi_request+0xa8/0x9d8)

[<c01af348>]
(mmc_spi_request+0x0/0x9d8) from [<c01a75f8>]
(mmc_wait_for_req+0x1f4/0x21c)

[<c01a7404>]
(mmc_wait_for_req+0x0/0x21c) from [<c01a768c>] (mmc_wait_for_cmd+0x6c/0x7c)

 r7:00000000 r6:ce0bf400
r5:ce091f1c r4:ce091ee4

[<c01a7620>]
(mmc_wait_for_cmd+0x0/0x7c) from [<c01ab4f0>] (mmc_reset_sdio+0x5c/0x6c)

 r7:ce090000 r6:ce0bf550
r5:ce0bf400 r4:ce091f1c

[<c01ab494>]
(mmc_reset_sdio+0x0/0x6c) from [<c01a71f0>] (mmc_rescan+0x24c/0x2ec)

 r5:60000013 r4:ce0bf400

[<c01a6fa4>]
(mmc_rescan+0x0/0x2ec) from [<c004eb28>] (worker_thread+0x138/0x1f8)

 r6:ce092de0 r5:ce0bf550
r4:ce0bf554

[<c004e9f0>]
(worker_thread+0x0/0x1f8) from [<c0052904>] (kthread+0x88/0x90)

[<c005287c>] (kthread+0x0/0x90)
from [<c003f9b8>] (do_exit+0x0/0x684)

 r7:00000000 r6:00000000
r5:00000000 r4:00000000

mmc0: req done (CMD52): -22:
00000000 00000000 00000000 00000000

mmc0: starting CMD0 arg 00000000
flags 000000c0

mmc_spi spi0.0:   mmc_spi:
CMD0, resp R1

 I am not able to identify the micro SD card. Is there
anything which i am missing?

 

Regards,

Sumesh. 		 	   		  
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100828/1ca3b06c/attachment-0001.html>
