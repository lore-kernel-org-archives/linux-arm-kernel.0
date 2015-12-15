From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 15 Dec 2015 14:50:51 +0000
Subject: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity
 bindings
In-Reply-To: <20151215142458.GI16007@e106622-lin>
References: <20151124020631.GA15165@rob-hp-laptop>
 <20151210153004.GA26758@sirena.org.uk>
 <20151210175820.GE14571@e106622-lin>
 <20151211174940.GQ5727@sirena.org.uk>
 <20151214123616.GC3308@e106622-lin>
 <20151214165928.GV5727@sirena.org.uk>
 <20151215122238.GG16007@e106622-lin>
 <20151215133951.GY5727@sirena.org.uk>
 <20151215140135.GI31299@leverpostej>
 <20151215142458.GI16007@e106622-lin>
Message-ID: <20151215145050.GA7041@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 02:24:58PM +0000, Juri Lelli wrote:
> Hi Mark,

Hi Juri,

> On 15/12/15 14:01, Mark Rutland wrote:
> > I really don't want to see a table of magic numbers in the kernel.
> 
> Doesn't seem to be a clean and scalable solution to me either. It is not
> easy to reconfigure when new core types come around, as I don't think
> relative data is always present or easy to derive, and it exposes some
> sort of centralized global information where everyone is compared
> against everyone.

I'm also concerned that it will be difficult to curate this to avoid
deceptive marketing numbers. These may not reflect reality.

> Where the DT solution is inherently per platform: no need to expose
> absolute values and no problems with knowing data regarding old core
> types.

The DT approach certainly avoids tying the kernel to a given idea of
particular microarchitectures.

> > If we cannot rely on external information, and want this information to
> > be derived by the kernel, then we need to perform some dynamic
> > benchmark. That would work for future CPUs the kernel knows nothing
> > about yet, and would cater for the pseudo-heterogeneous cases too.
> 
> I've actually experimented a bit with this approch already, but I wasn't
> convinced of its viability. It is true that we remove the burden of
> coming up with default values from user/integrator, but I'm pretty sure
> we will end up discussing endlessly about which particular benchmark to
> pick 

Regardless of which direction we go there will be endless discussion as
to the benchmark. As Mark pointed out, that happened in the case of the
table, and it's happening now for the DT approach.

I think we agree that if this is something we can change later (i.e. we
don't rely on an external oracle like DT) the particular benchmark
matters less, as that can be changed given evidence of superiority.

> and the fact that it impacts on boot time and such.

I was under the impression that the kernel already did RAID algorithm
benchmarking as part of the boot process. Maybe we can find a set of
similarly brief benchmarks.

Thanks,
Mark.
