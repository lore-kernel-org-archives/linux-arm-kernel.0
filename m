From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 23 Nov 2016 18:10:56 -0800
Subject: [PATCH 2/2] clk: uniphier: add clock data for cpufreq
In-Reply-To: <CAK7LNAQ6XeSHd7DbvD1jWeMfOqk8+R27Q-fNDWtXxpRd=OFgjA@mail.gmail.com>
References: <1477503088-26508-1-git-send-email-yamada.masahiro@socionext.com>
 <1477503088-26508-2-git-send-email-yamada.masahiro@socionext.com>
 <20161124000503.GE6095@codeaurora.org>
 <CAK7LNAQ6XeSHd7DbvD1jWeMfOqk8+R27Q-fNDWtXxpRd=OFgjA@mail.gmail.com>
Message-ID: <20161124021056.GJ6095@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24, Masahiro Yamada wrote:
> Hi Stephen,
> 
> 
> 2016-11-24 9:05 GMT+09:00 Stephen Boyd <sboyd@codeaurora.org>:
> 
> >> +#if 1
> >> +     /*
> >> +      * TODO:
> >> +      * The return type of .round_rate() is "long", which is 32 bit wide on
> >> +      * 32 bit systems.  Clock rate greater than LONG_MAX (~ 2.15 GHz) is
> >> +      * treated as an error.  Needs a workaround until the problem is fixed.
> >> +      */
> >
> > Just curious is the problem internal to the clk framework because
> > of the clk_ops::round_rate design? Or does the consumer, cpufreq
> > in this case, have to deal with rates that are larger than
> > unsigned long on a 32 bit system? If it's just a clk_ops problem
> > and we need to support rates up to 32 bits wide (~ 4.3 GHz) on
> > the system then the driver could be changed to use
> > .determine_rate() ops and that would allow us to use all the bits
> > of unsigned long to figure out rates.
> >
> > If the problem is rates even larger than unsigned long on 32 bit
> > systems, then at the least I'd like to see some sort of plan to
> > fix that in the framework before merging code. Hopefully it can
> > be done gradually, but as I start looking at it it seems more and
> > more complicated to support this so this will be a long term
> > project.
> >
> > We can discuss the clk API changes needed as well if those are
> > required, but that is another issue that requires changes in
> > other places outside of clk drivers.
> >
> 
> I understand your point, but core frame-work changes
> need more careful review than clk data changes in low-level drivers.
> It is too late to be included in v4.10.
> 
> If I drop 32bit SoC things, and send v2 only for 64bit SoCs,
> is that acceptable for 4.10-rc1?

Sure. That sounds fine for now. I'll reply to your other thread
with a plan of attack on how to do the framework changes. I think
we need to do those regardless of the outcome of your
investigation.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
