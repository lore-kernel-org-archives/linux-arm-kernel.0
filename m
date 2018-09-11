From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Tue, 11 Sep 2018 12:04:09 +0100
Subject: [PATCH 1/4] sched/topology: SD_ASYM_CPUCAPACITY flag detection
In-Reply-To: <20180910082111.GA48257@gmail.com>
References: <1532093554-30504-1-git-send-email-morten.rasmussen@arm.com>
 <1532093554-30504-2-git-send-email-morten.rasmussen@arm.com>
 <20180910082111.GA48257@gmail.com>
Message-ID: <20180911110409.GA16613@e105550-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 10:21:11AM +0200, Ingo Molnar wrote:
> 
> * Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> 
> > The SD_ASYM_CPUCAPACITY sched_domain flag is supposed to mark the
> > sched_domain in the hierarchy where all cpu capacities are visible for
> > any cpu's point of view on asymmetric cpu capacity systems. The
> 
> >  /*
> > + * Find the sched_domain_topology_level where all cpu capacities are visible
> > + * for all cpus.
> > + */
> 
> > +	/*
> > +	 * Examine topology from all cpu's point of views to detect the lowest
> > +	 * sched_domain_topology_level where a highest capacity cpu is visible
> > +	 * to everyone.
> > +	 */
> 
> >  #define SD_WAKE_AFFINE               0x0020  /* Wake task to waking CPU */
> > -#define SD_ASYM_CPUCAPACITY  0x0040  /* Groups have different max cpu capacities */
> > +#define SD_ASYM_CPUCAPACITY  0x0040  /* Domain members have different cpu capacities */
> 
> For future reference: *please* capitalize 'CPU' and 'CPUs' in future patches like the rest of 
> the scheduler does.
> 
> You can see it spelled right above the new definition: 'waking CPU' ;-)
> 
> (I fixed this up in this patch.)

Noted. Thanks for fixing up the patch.

Morten
