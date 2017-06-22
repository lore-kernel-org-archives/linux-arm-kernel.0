From: juri.lelli@arm.com (Juri Lelli)
Date: Thu, 22 Jun 2017 17:43:45 +0100
Subject: [PATCH V2 4/5] arch_topology: Return 0 or -ve errors from
 topology_parse_cpu_capacity()
In-Reply-To: <20170622142816.GC6314@vireshk-i7>
References: <cover.1498019799.git.viresh.kumar@linaro.org>
 <2213a1f0657ef057dd775085943b362dc3e9757d.1498019799.git.viresh.kumar@linaro.org>
 <20170622093957.vlhacauj4vff64bv@e106622-lin>
 <20170622142816.GC6314@vireshk-i7>
Message-ID: <20170622164345.z7w2e6nhtqrua34v@e106622-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/06/17 19:58, Viresh Kumar wrote:
> On 22-06-17, 10:39, Juri Lelli wrote:
> > Hi,
> > 
> > On 21/06/17 10:16, Viresh Kumar wrote:
> > > Use the standard way of returning errors instead of returning 0(failure)
> > > OR 1(success) and making it hard to read.
> > > 
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  arch/arm/kernel/topology.c   | 2 +-
> > >  drivers/base/arch_topology.c | 8 ++++----
> > >  2 files changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> > > index bf949a763dbe..a7ef4c35855e 100644
> > > --- a/arch/arm/kernel/topology.c
> > > +++ b/arch/arm/kernel/topology.c
> > > @@ -111,7 +111,7 @@ static void __init parse_dt_topology(void)
> > >  			continue;
> > >  		}
> > >  
> > > -		if (topology_parse_cpu_capacity(cn, cpu)) {
> > > +		if (!topology_parse_cpu_capacity(cn, cpu)) {
> > 
> > Not sure why you want to change this.
> 
> I just didn't find it straight forward to read.
> 
> > I currently read it as "if cpu_capacity parsing succedeed" continue with
> > next CPU, otherwise we set cap_from_dt to false and fall back to using
> > efficiencies.
> 
> Actually, I can just make the return type bool and that should solve
> the issues I was seeing and keep the code as it is.
> 
> Will that be fine ?
> 

Think so.
