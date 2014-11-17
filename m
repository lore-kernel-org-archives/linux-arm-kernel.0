From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Mon, 17 Nov 2014 02:12:51 +0000
Subject: mvebu: tclk detection for armada-xp and marvell packet processor
 with integrated CPU
Message-ID: <546959A3.9040206@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

One of the first problems I encountered looking at the Marvell Packet 
Processor with integrated CPU (I'll refer to that as 'the PP' throughout 
the rest of this email) was that it has a different TCLK to the armada-xp.

It appears that for both the PP and the armada-xp the TCLK is hard-coded 
(to 200MHz and 250MHz respectively) and cannot be detected as far as I 
can see from the various data-sheets. I was hoping to re-use 
drivers/clk/mvebu/armada-xp.c but I need to figure out how to make 
axp_get_tclk_freq() give me an appropriate answer depending on the SoC. 
If this were in the mach-mvebu code I could just use mvebu_get_soc_id() 
to fetch the device id. Is there an equivalent I could use in generic code?

One option would be to use a different compatible string in the dts. 
That would also give me a way of handling other differences (the 
clock-gating is a subset of what's available on the armada-xp). How 
different would things have to be before it's worth spinning the PP code 
out into a file of it's own?

Thanks,
Chris
