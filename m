From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 15 Jan 2017 22:08:18 +0100 (CET)
Subject: mmc: core: complete/wait_for_completion performance
In-Reply-To: <1484512950.2026.4.camel@embedded.rocks>
References: <1479644869.2653.3.camel@embedded.rocks>
 <585759233.283839.1cb53b4d-2805-48ea-aef1-dd282306d108.open-xchange@email.1und1.de>
 <1479652929.2841.1.camel@embedded.rocks>
 <187975187.249177.bccdc17e-e9c6-48c2-aeaf-3b81f1b61ec7.open-xchange@email.1und1.de>
 <1479669034.1975.1.camel@embedded.rocks>
 <1198138554.59982.63209ba1-8fb4-4a13-9ee0-f746a192f4c7.open-xchange@email.1und1.de>
 <1481095953.17027.0.camel@embedded.rocks>
 <123257138.400786.e58aee3b-9fc2-4b39-a030-c2409c5b92fc.open-xchange@email.1und1.de>
 <1481706204.3994.4.camel@embedded.rocks>
 <962480933.163666.1481741832090@email.1und1.de>
 <1481809814.29241.2.camel@embedded.rocks>
 <875319194.240552.1481827900469@email.1und1.de>
 <1481882798.31185.3.camel@embedded.rocks>
 <692865692.72725.1482793390055@email.1und1.de>
 <1484512950.2026.4.camel@embedded.rocks>
Message-ID: <264982492.171431.1484514498854@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi J?rg,

> J?rg Krause <joerg.krause@embedded.rocks> hat am 15. Januar 2017 um 21:42 geschrieben:
> 
> 
> Hi Stefan,
> 
> On Tue, 2016-12-27 at 00:03 +0100, Stefan Wahren wrote:
> > Hi J?rg,
> > ...
> > I also rebased an old patch from Shawn Guo [2] with pre_req and
> > post_req support, tried to call the DMA channel callback from the
> > interrupt context instead of scheduling the tasklet within the DMA
> > engine driver and implement CMD23 support [3]. But none of them show
> > any measurable performance improvement.
> 
> I tested the three patches after disabling any debugging options in the
> config. There is no performance gain, but the timings have changed.
> Please have a look at the attached graphs. The time between complete()
> and wait_for_completion() is reduced to 15us whereas the time from
> return from wait_for_completion() to return to sdio_readsb() increases
> to 23us (from maybe 2us before).

that confirms my results. I think you are searching on the wrong layer. You better step "back" and take a look at the whole transfer instead of single blocks. Maybe there are some bigger delays.

Stefan

> 
> J?rg
