From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 13 Jul 2017 15:06:08 +0530
Subject: [RFC v2 5/6] drivers: boot_constraint: Add initial DT bindings
In-Reply-To: <CAL_Jsq+oAB3gejRMXuY0q9+Et4GrtvF3RwGzPNJ08TPooVyXJg@mail.gmail.com>
References: <cover.1499770771.git.viresh.kumar@linaro.org>
 <0610277aef9830cff53b7b53cf41cc54886fdc7f.1499770771.git.viresh.kumar@linaro.org>
 <CAL_Jsq+oAB3gejRMXuY0q9+Et4GrtvF3RwGzPNJ08TPooVyXJg@mail.gmail.com>
Message-ID: <20170713093608.GF352@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-07-17, 16:28, Rob Herring wrote:
> Display is a pretty well known use case here. Do you have other
> examples in mind?

No, I don't.

@Stephen: Do you have more cases like this for your Qcom products ?

> Other cases I've seen are automotive with keeping
> the backup camera going and CAN bus handling. Though my new car has a
> flicker shortly after coming on, so I guess the handoff doesn't have
> to be completely seemless. :)

:)

> [...]
> 
> > +       mmc: mmc at 0x0 {
> > +               ...
> > +               ...
> > +               vmmc-supply = <&twl_reg1>;
> > +               vmmcaux-supply = <&twl_reg2>;
> > +               boot-constraint-supplies = "vmmc", "vmmcaux";
> > +               boot-constraint-uV = <1800000 2000000>, /* vmmc */
> > +                                    <2000000 2000000>; /* vmmcaux */
> 
> No. I don't like how this is going to extend to all the other bindings
> people are going to want constraints for. We don't need a parallel set
> of properties for each type of binding.

Fair enough.

> I'm not convinced that we need a general solution for what's probably
> a handful of things that need a handoff versus just re-initialize.

What about keeping the first four patches (mostly) as it is and adding
these constraints from a platform specific constraints driver ?

Will that be acceptable ?

-- 
viresh
