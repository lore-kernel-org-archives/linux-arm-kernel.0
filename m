From: lethal@linux-sh.org (Paul Mundt)
Date: Thu, 7 Oct 2010 03:38:02 +0900
Subject: [PATCH 2/7] perf: New helper function for pmu name
In-Reply-To: <20101006181548.GU13563@erda.amd.com>
References: <cover.1286222593.git.matt@console-pimps.org>
	<59a8e68894a2e755232189abbe9b1a3b892e309c.1286222593.git.matt@console-pimps.org>
	<20101006181548.GU13563@erda.amd.com>
Message-ID: <20101006183801.GA13879@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 06, 2010 at 08:15:48PM +0200, Robert Richter wrote:
> On 04.10.10 16:44:20, Matt Fleming wrote:
> > Introduce perf_pmu_name() helper function that returns the name of the
> > pmu. This gives us a generic way to get the name of a pmu regardless of
> > how an architecture identifies it internally, e.g. ARM uses an id
> > whereas SH currently uses a string.
> > 
> 
> Matt,
> 
> as an outcome of the discussion we have had in this thread I think we
> agree on the following:
> 
> We extend the generic perf interface with perf_pmu_name() implenting a
> default with the __weak attribute.  On sh we override this function
> and will use it for perf/oprofile string translation. This will be
> implemented in the oprofile function op_name_from_perf_name().
> 
> Later we implement a generic oprofile function that derives the
> cpu_type from perf_pmu_name() in a generic way and add other
> architectures. Thus, we will drop the ARM changes with this patch set.
> 
> Paul,
> 
> please correct me if I am wrong with the above.
> 
That all sounds fine to me, thanks for summarizing!
