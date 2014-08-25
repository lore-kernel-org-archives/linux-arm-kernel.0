From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 25 Aug 2014 12:35:44 +0530
Subject: [RFC] cpufreq: Add bindings for CPU clock sharing topology
In-Reply-To: <20140725200214.22930.56323@quantum>
References: <7e097b71342c9f5f63b07ff2e135eb7beb626aab.1405661369.git.viresh.kumar@linaro.org>
 <CAOesGMhTkTEXp99gpU8cZBwYmiXpsySG5zMn6oSyo_Mf5PAiUg@mail.gmail.com>
 <CAKohpo=MmoALOHg-=7cf0jm=OJO57TWQZQXqkRwhRwU-DGPMmA@mail.gmail.com>
 <CAOesGMhuNzVtUkaUjF+JjNgHcgf08WiM0DG-kzwtcyUxkK_zow@mail.gmail.com>
 <CAKohpokLqrydV3b=innvOWrW9ijXtZwPKdT5Ew65cjMxsY2Mvw@mail.gmail.com>
 <53CA8D95.8010108@ti.com>
 <CAKohpok-C+JCebjJkZExx6EjBctoyJF7fV71Vjj7bi1TAdXrFQ@mail.gmail.com>
 <20140724003314.6419.51564@quantum>
 <CABGGisxHxdTyh500ey+KVLV3EnfYZvtsCV=Nt4Nqu7p6KJOwdA@mail.gmail.com>
 <CAKohpo=CqhA-TOfJh3U0G+tEMqvn_tiyWK=Yd6yNdAoDYQ-1BA@mail.gmail.com>
 <20140725200214.22930.56323@quantum>
Message-ID: <CAKohpo=s9A_EtJ2d2E9sjVkR8xs-bgRisnk=jZUeyWEf3uP5gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 July 2014 01:32, Mike Turquette <mike.turquette@linaro.org> wrote:
> So my opinion is to figure out how to specify the shared-clock versus
> independent-clock parameter it DT. I think the big issue here is the
> topology semantics around the cpus node, and I'll stay out of that
> stuff. But let's please not introduce a random API for a single merge
> window and let's also not over-consolidate machine driver code just for
> the sake of having fewer C files.

Returning almost after a month to this :(

- I agree that consolidation to cpufreq-cpu0 driver is good but adding a
backend clk driver for that is bad. I would look around supporting callbacks
to cpufreq-cpu0 driver. So that ->target()/->target_index() can be specified
by platform drivers and rest of the code can be used. But that's the next
problem to solve.

- Back to the first issue. How do we sharing information from DT ?

As I read them (and I may be wrong in understanding that), there were
conflicting ideas from many..

Can we please decide how we want to see these bindings? So, that I can
implement them quickly and close this thread...

Its just hanging in the middle as there wasn't a single clean solution yet.

--
viresh
