From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Thu, 16 Aug 2012 09:36:44 +0000
Subject: [PATCH v2 04/14] ARM: OMAP5: Add minimal support for OMAP5430 SOC
In-Reply-To: <alpine.DEB.2.00.1208151618590.1731@utopia.booyaka.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
 <1341566515-22665-5-git-send-email-santosh.shilimkar@ti.com>
 <4FFA9B61.8030808@ti.com> <20120709131156.GH1122@atomide.com>
 <alpine.DEB.2.00.1208151618590.1731@utopia.booyaka.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA91188@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 03:56:42, Paul Walmsley wrote:
> Hi
> 
> On Mon, 9 Jul 2012, Tony Lindgren wrote:
> 
> > Below (untested) is what could be done in the short term.
> 
> That's fine with me.  Do you want to queue it or do you want me to queue 
> it?
> 
> > Heh these CK_XXXX defines are now running out of the u16 cpu_mask.
> > 
> > They really should be replaced with SoC specific lists of clocks
> > rather than bloating the cpu_mask and repeating it for every clock
> > that's compiled in for 800+ times.
> 
> Frankly, an extra 1.6KB -- uncompressed -- is pretty low on my list of 
> bloat concerns for multi-OMAP kernels.  If it were up to me, I'd just 
> change it to a u32 and be done with the problem for the foreseeable 
> future.
> 
> > I wonder if we could #define CK_OMAP_DUMMY 0 that's always set
> > for non-shared clocks if they only get set in some *_data.c
> > file in a unique way?
> > 
> > Paul got any better ideas?
> 
> Aside from using u32?  Not really.  As we've discussed in the past, at 
> some point we should convert the clock initialization to using some kind 
> of per-SoC list.  But it doesn't seem worth spending too much time on that 
> while the common clock framework conversion is higher priority.
> 
> 

This reminds me for AM33xx clock-tree migration to common-clock framework,
so just wanted to update on this, I have already converted the clock-tree to 
common-clock fw, on top of Rajendra's repository.

Now waiting on Rajendra for his next series...

Thanks,
Vaibhav
