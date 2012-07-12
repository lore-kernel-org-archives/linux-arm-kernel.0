From: attila@kinali.ch (Attila Kinali)
Date: Thu, 12 Jul 2012 17:13:50 +0200
Subject: mmc: mxs: DEADLOCK
In-Reply-To: <20120712143950.GA16343@S2101-09.ap.freescale.net>
References: <4FFC367A.8020100@bluegiga.com>
 <20120711060607.GE14060@S2101-09.ap.freescale.net>
 <20120712160008.03731746cdc5cf4bb0548256@kinali.ch>
 <20120712143950.GA16343@S2101-09.ap.freescale.net>
Message-ID: <20120712171350.011ee50f582c10f962ba1e48@kinali.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Jul 2012 22:39:53 +0800
Shawn Guo <shawn.guo@linaro.org> wrote:

> > 
> > I ran into the same problem today, but the proposed fix doesn't seem
> > to work for me:
> > 
> It's a different problem from what Lauri reported and fixed.  

Ok... 

> I haven't
> played SDIO card that much, so I'm not completely clear about the SDIO
> calling sequence, but is it reasonable that mxs_mmc_enable_sdio_irq is
> being called recursively?

I don't know. I dont know the code at all and not how the sdio system
works. But a quick check shows, that mxs_mmc_enable_sdio_irq does not
call any other function (besides readel, writel) and hence cannot call itself.

For me it rather looks like that there seem to be two consequtive
irqs that get passed to sdio_irq_thread which then calls 
mxs_mmc_enable_sdio_irq.

But with my limited knowledge i cannot check this theory.
Can anyone give me some hints how i could verify this?

			Attila Kinali

-- 
The trouble with you, Shev, is you don't say anything until you've saved
up a whole truckload of damned heavy brick arguments and then you dump
them all out and never look at the bleeding body mangled beneath the heap
		-- Tirin, The Dispossessed, U. Le Guin
