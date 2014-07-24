From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 24 Jul 2014 16:09:31 +0530
Subject: [RFC] cpufreq: Add bindings for CPU clock sharing topology
In-Reply-To: <CABGGisxHxdTyh500ey+KVLV3EnfYZvtsCV=Nt4Nqu7p6KJOwdA@mail.gmail.com>
References: <7e097b71342c9f5f63b07ff2e135eb7beb626aab.1405661369.git.viresh.kumar@linaro.org>
 <CAOesGMhTkTEXp99gpU8cZBwYmiXpsySG5zMn6oSyo_Mf5PAiUg@mail.gmail.com>
 <CAKohpo=MmoALOHg-=7cf0jm=OJO57TWQZQXqkRwhRwU-DGPMmA@mail.gmail.com>
 <CAOesGMhuNzVtUkaUjF+JjNgHcgf08WiM0DG-kzwtcyUxkK_zow@mail.gmail.com>
 <CAKohpokLqrydV3b=innvOWrW9ijXtZwPKdT5Ew65cjMxsY2Mvw@mail.gmail.com>
 <53CA8D95.8010108@ti.com>
 <CAKohpok-C+JCebjJkZExx6EjBctoyJF7fV71Vjj7bi1TAdXrFQ@mail.gmail.com>
 <20140724003314.6419.51564@quantum>
 <CABGGisxHxdTyh500ey+KVLV3EnfYZvtsCV=Nt4Nqu7p6KJOwdA@mail.gmail.com>
Message-ID: <CAKohpo=CqhA-TOfJh3U0G+tEMqvn_tiyWK=Yd6yNdAoDYQ-1BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 July 2014 07:54, Rob Herring <rob.herring@linaro.org> wrote:

>> A previous approach tried to compare struct clk pointers, which is a bad
>> idea since those are just cookies and should not be deref'd by drivers.
>> However a similar approach would be to compare the phandle, right?

Yeah. So what's the right way then?

> I think there needs to be a way to query whether a rate change for a
> clock affects other children. As pointed out previously, the clock to
> a core may not be shared, but it's parent that can change rates could
> be shared. This could be done with functions
> clk_get_parent_rate_change to return the clock in heirarchy which can
> change rates, and clk_is_parent_clk which tells if one clock is a
> child of another clock. It's been a while since I've looked at the
> clock api. It could also be done by experiment. Change the rate for
> core 0 and see if core 1's rate is changed and still equal. There's
> probably some ordering issue with doing that though.

But Mike sort of Nak'd that as well earlier :)
