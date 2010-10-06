From: lethal@linux-sh.org (Paul Mundt)
Date: Thu, 7 Oct 2010 00:57:04 +0900
Subject: [PATCH 2/7] perf: New helper function for pmu name
In-Reply-To: <20101006155026.GT13563@erda.amd.com>
References: <cover.1286222593.git.matt@console-pimps.org>
	<59a8e68894a2e755232189abbe9b1a3b892e309c.1286222593.git.matt@console-pimps.org>
	<20101006122736.GL13563@erda.amd.com>
	<20101006123950.GA29118@linux-sh.org>
	<20101006131825.GO13563@erda.amd.com>
	<20101006133041.GA29273@linux-sh.org>
	<20101006155026.GT13563@erda.amd.com>
Message-ID: <20101006155704.GB10220@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 06, 2010 at 05:50:26PM +0200, Robert Richter wrote:
> On 06.10.10 09:30:41, Paul Mundt wrote:
> > On Wed, Oct 06, 2010 at 03:18:25PM +0200, Robert Richter wrote:
> > > So, I am also fine with implementing a generic perf_pmu_name() for sh
> > > and then derive the oprofile cpu_type string from it in the oprofile
> > > code.
> > > 
> > Again, this is unacceptable.
> 
> Paul,
> 
> maybe I misunderstood you, but isn't this you preferred solution? We
> make perf_pmu_name() part of the generic i/f and then derive the
> oprofile name from the pmu name provided by perf.
> 
Perhaps we've misunderstood each other. I thought what you meant is that
we would carry a special API deviation in the architecture code or expose
the sh_pmu structure to generic code, both of which I have no interest
in. My preferred solution is that we provide a perf_pmu_name() in the
generic perf code as a __weak and then override it in the sh code, where
we have sh_pmu visibility. This way we aren't providing any special APIs
and sh_pmu remains constrained to the sh perf events code.
