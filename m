From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 9 Jun 2011 17:45:57 +0100
Subject: ARM/DT: registering clks from DT in .init_early
Message-ID: <20110609164557.GK3711@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm currently working on moving our platform to device tree with the aim 
of mainlining it.  Before device tree we registered the clks in the 
.init_early machine callback which is fine as the clks are static data.  
I'm now trying to dynamically register these clks from the device tree 
but the slab allocator isn't available at this stage so I can't allocate 
them dynamically.

Am I heading in the wrong direction here?  We currently get the 
clocksource and clock event frequency from a clk so I don't think this 
can be made later (though I guess this could come from device tree 
instead).

Jamie
