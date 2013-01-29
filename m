From: tony@atomide.com (Tony Lindgren)
Date: Tue, 29 Jan 2013 09:24:11 -0800
Subject: [PATCH 08/10] ARM: OMAP5: hwmod data: Create initial OMAP5 SOC
 hwmod data
In-Reply-To: <5107D52C.80200@ti.com>
References: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com>
 <1358522856-12180-9-git-send-email-santosh.shilimkar@ti.com>
 <20130118171500.GC15361@atomide.com> <50FCF838.6000105@ti.com>
 <50FD5993.5010008@ti.com> <20130121180113.GA22517@atomide.com>
 <50FE8C5C.2030409@ti.com> <20130122183213.GN15361@atomide.com>
 <5107D52C.80200@ti.com>
Message-ID: <20130129172410.GS15361@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130129 05:59]:
> OK so we do managed to clean up the address space, IRQ lines
> and DMA request lines data from hwmod completely.
> 
> -OMAP5 hwmod data file, 2076 lines we could remove which significant
> reduction. I ran the same scripts on OMAP4 and there too about 2200
> lines getting deleted.

Great, thanks for looking into it. I guess we cannot do that quite
yet for omap4 as we have not made it DT only. But we should be able
to do that for am33xx as that's DT only already.
 
> - I have to udapte DT file to add the all supported hwmods with reg
> property so that OMAP5 continue to boot. Similar work is needed for
> OMAP4 too once OMAP4 is made DT only support.

OK
 
> - To my suprise, the DT lookup isn't that bad. It is adding just
> 24 milliseconds to the boot time which is more or less noise.

That's good to hear.
 
> Have pushed a branch with above update for OMAP5 here [1]
> 
> So we are left with two other topics which you mentioned in the
> comments.
> 
> 1. Movement of clock data to drivers/clk. Till we get direction here
> I would like to hear the alternative to get OMAP5 booting from mainline.
> If there is no alternative, we can keep OMAP5 clock data alone
> out of tree and get rest of the data files merged.

I agree, no reason to hold back the other patches. But we should
resolve the common clock move to drivers/clk properly now,
otherwise it will just get postponed again and we have even bigger
problem to deal with.

> 2. The iormap() done by hwmod for sysconfig handling which you are
> discussing with Rajendra. So far we don't have a viable way to
> get the iormapped address from device drivers back to platform
> code. Lets continue on this thread but this can evolve in
> parallel.

Yes that can be fixed separately.

Regards,

Tony

 
> [1] git://github.com/SantoshShilimkar/linux.git
> 3.9/omap5-testing-hwmod-cleanup
