From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Jan 2015 10:16:45 +0000
Subject: [PATCH v4 05/13] pm: at91: move the copying the sram function to
 the sram initializationi phase
In-Reply-To: <B256D81BAE5131468A838E5D7A243641BFD3A091@penmbx01>
References: <1422409172-24178-1-git-send-email-wenyou.yang@atmel.com>
 <1422409396-24394-1-git-send-email-wenyou.yang@atmel.com>
 <20150129112800.GV26493@n2100.arm.linux.org.uk>
 <B256D81BAE5131468A838E5D7A243641BFD3A091@penmbx01>
Message-ID: <20150130101645.GH26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 06:59:58AM +0000, Yang, Wenyou wrote:
> Hi Russell,
> 
> Thank you for your review.
> 
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> > 
> > On Wed, Jan 28, 2015 at 09:43:16AM +0800, Wenyou Yang wrote:
> > > @@ -272,6 +268,9 @@ static void __init at91_pm_sram_init(void)
> > >  	sram_pbase = gen_pool_virt_to_phys(sram_pool, sram_base);
> > >  	slow_clock = __arm_ioremap_exec(sram_pbase, at91_slow_clock_sz,
> > > false);
> > >
> > > +	/* Copy the slow_clock handler to SRAM */
> > > +	memcpy(slow_clock, at91_slow_clock, at91_slow_clock_sz);
> > > +
> > 
> > Why is this code not using the fncpy() support for copying functions.
> At first, used the fncpy(), but it work not well on the some chip. I
> will check it again.

Please report on this; why does it "work not well" ?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
