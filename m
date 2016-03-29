From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Tue, 29 Mar 2016 13:14:43 +0200
Subject: DCD interrupt for i.MX25 UART
In-Reply-To: <20160323153638.GO6191@pengutronix.de>
References: <20160323153638.GO6191@pengutronix.de>
Message-ID: <20160329131443.09e46ad6@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 23 Mar 2016 16:36:38 +0100 Uwe Kleine-K?nig wrote:
> Hello,
> 
> I have a problem with an UART on an i.MX25 based machine. I implemented
> DCD (and other handshake lines) irq handling[1].
> 
> Now a user of this patch noticed that DCD handling (at least) is broken.
> The problem is that the USR2_DCDDELT bit doesn't clear:
> 
> 	root at hostname:~ memtool md 0x43f90080+0x34  
> 	43f90080: 00000000 00004021 0000078c 00004002                ....!@....... at ..
> 	43f90090: 00000b41 00002040 00005268 0000002b                A...@ ..hR..+...
> 	43f900a0: 00000000 000000bf 00002e62 00000008                ........b.......
> 	43f900b0: 0000251c                                           .%..
> 
> 	root at hostname:~ memtool mw 0x43f90098 0x0x40
                                              ^^^^^^
This looks rather fishy.

> 	root at hostname:~ memtool md 0x43f90080+0x34  
> 	43f90080: 00000000 00004021 0000078c 00004002                ....!@....... at ..
> 	43f90090: 00000b41 00002040 00005268 0000002b                A...@ ..hR..+...
> 	43f900a0: 00000000 000000bf 00002e62 00000008                ........b.......
> 	43f900b0: 0000251c                                           .%..
> 
> In fact even writing 0xffff doesn't change the register, where I would expect
> that the DCDDELT bit (0x40) disappears. I'm sure there is nothing toggling this
> line.
> 
Are you sure the clock is enabled when doing your manual tests?


Lothar Wa?mann
