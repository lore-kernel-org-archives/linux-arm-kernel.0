From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Tue, 16 Feb 2016 09:04:24 +0100
Subject: [PATCH v3 4/5] arm64/perf: Enable PMCR long cycle counter bit
In-Reply-To: <20160215195529.GW6298@arm.com>
References: <cover.1454516082.git.jglauber@cavium.com>
 <de7340e1843f7823384551db64b12eadde7eded7.1454516082.git.jglauber@cavium.com>
 <20160215195529.GW6298@arm.com>
Message-ID: <20160216080424.GB3490@hardcore>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 07:55:29PM +0000, Will Deacon wrote:
> On Wed, Feb 03, 2016 at 06:11:59PM +0100, Jan Glauber wrote:
> > @@ -768,8 +776,11 @@ static void armv8pmu_reset(void *info)
> >  		armv8pmu_disable_intens(idx);
> >  	}
> >  
> > -	/* Initialize & Reset PMNC: C and P bits. */
> > -	armv8pmu_pmcr_write(ARMV8_PMCR_P | ARMV8_PMCR_C);
> > +	/*
> > +	 * Initialize & Reset PMNC. Request overflow on 64 bit but
> > +	 * cheat in armv8pmu_write_counter().
> 
> Can you expand the comment to mention that the 64-bit overflow is only
> for the cycle counter, please?

OK, how about:

/*
 * Initialize & Reset PMNC. Request overflow interrupt for
 * 64 bit cycle counter but cheat in armv8pmu_write_counter().
 */

Jan

> Will
