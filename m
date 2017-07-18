From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 18 Jul 2017 11:28:04 +0530
Subject: [RFC v2 5/6] drivers: boot_constraint: Add initial DT bindings
In-Reply-To: <20170717173407.x5qjnrxqkjvn5vdm@rob-hp-laptop>
References: <cover.1499770771.git.viresh.kumar@linaro.org>
 <0610277aef9830cff53b7b53cf41cc54886fdc7f.1499770771.git.viresh.kumar@linaro.org>
 <CAL_Jsq+oAB3gejRMXuY0q9+Et4GrtvF3RwGzPNJ08TPooVyXJg@mail.gmail.com>
 <20170713093608.GF352@vireshk-i7>
 <20170717173407.x5qjnrxqkjvn5vdm@rob-hp-laptop>
Message-ID: <20170718055804.GV352@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17-07-17, 12:34, Rob Herring wrote:
> On Thu, Jul 13, 2017 at 03:06:08PM +0530, Viresh Kumar wrote:
> > On 12-07-17, 16:28, Rob Herring wrote:
> > > Display is a pretty well known use case here. Do you have other
> > > examples in mind?
> > 
> > No, I don't.
> > 
> > @Stephen: Do you have more cases like this for your Qcom products ?
> > 
> > > Other cases I've seen are automotive with keeping
> > > the backup camera going and CAN bus handling. Though my new car has a
> > > flicker shortly after coming on, so I guess the handoff doesn't have
> > > to be completely seemless. :)
> > 
> > :)
> > 
> > > [...]
> > > 
> > > > +       mmc: mmc at 0x0 {
> > > > +               ...
> > > > +               ...
> > > > +               vmmc-supply = <&twl_reg1>;
> > > > +               vmmcaux-supply = <&twl_reg2>;
> > > > +               boot-constraint-supplies = "vmmc", "vmmcaux";
> > > > +               boot-constraint-uV = <1800000 2000000>, /* vmmc */
> > > > +                                    <2000000 2000000>; /* vmmcaux */
> > > 
> > > No. I don't like how this is going to extend to all the other bindings
> > > people are going to want constraints for. We don't need a parallel set
> > > of properties for each type of binding.
> > 
> > Fair enough.
> > 
> > > I'm not convinced that we need a general solution for what's probably
> > > a handful of things that need a handoff versus just re-initialize.
> > 
> > What about keeping the first four patches (mostly) as it is and adding
> > these constraints from a platform specific constraints driver ?
> > 
> > Will that be acceptable ?
> 
> Meaning no DT binding? Then I don't care (from a DT perspective).

Yeah, kind of the way we decided to do the first step in the
power domain performance state series [1].

And then later on we can see how to get such information from DT, as
the kernel needs this information irrespective of the way we solve
this problem in the kernel.

-- 
viresh

[1] https://marc.info/?l=linux-kernel&m=149802907711074&w=2
