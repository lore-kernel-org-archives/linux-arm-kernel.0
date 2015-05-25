From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 25 May 2015 17:29:13 +0530
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <20150521043310.GD22904@linux>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <555BDA7C.7020506@codeaurora.org> <20150520020715.GA6465@linux>
 <555CE2E6.80304@codeaurora.org> <20150521043310.GD22904@linux>
Message-ID: <20150525115913.GC23464@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21-05-15, 10:03, Viresh Kumar wrote:
> On 20-05-15, 12:39, Stephen Boyd wrote:
> > On 05/19/15 19:07, Viresh Kumar wrote:
> > > On 19-05-15, 17:51, Stephen Boyd wrote:
> > >
> > >> Also I wonder if all properties should be optional? I don't have this
> > >> scenario today, but perhaps the frequencies could be encoded in fuses,
> > >> but the voltages wouldn't be and so we might want to read out the
> > >> frequencies for a fixed set of voltages. Of course, if there's nothing
> > >> in the OPP node at all, it's not very useful, so perhaps some statement
> > >> that at least one of the frequency/voltage/amperage properties should be
> > >> present.
> > > I am not sure. What we are trying to do (fill partially in DT and
> > > partially in platform), is a trick and not the right use of bindings.
> > >
> > > Ideally whatever is passed in DT should be complete by itself and
> > > doesn't require platform to tweak it (which it can't). For example,
> > > the cpufreq-dt driver will try to initialize OPPs from the DT directly
> > > and wouldn't know about the platform tweaks. That can work eventually
> > > as platform will add OPPs for the same bindings before cpufreq driver
> > > will try to do, but that's a trick.
> > >
> > > And then its all about frequency in the first place, and so marking
> > > that optional looks wrong. Probably not the right use of these
> > > bindings.
> > 
> > Ok then I won't be using these bindings on any of the new platforms I
> > have where half the data is in one place, and half in another. But for
> > some of Krait based platforms I have they should be useable.
> 
> You are not the only one, I have seen other requests (even for the
> existing bindings) to fill stuff partially in DT as they want freq to
> come from bootloader.
> 
> @Rob: What do you suggest for such platforms? Let them keep (ab)using
> old or new OPP DT bindings or create another binding to just pass on
> freq table?

Rob: Can you please comment on this one as well ? Thanks.

-- 
viresh
