From: mturquette@baylibre.com (Michael Turquette)
Date: Tue, 16 Feb 2016 11:40:04 -0800
Subject: breaking DT compatibility (was: Re: [PATCH v4] clk: sunxi:
 Refactor A31 PLL6 so that it can be reused)
In-Reply-To: <20160216084448.GE4344@lukather>
References: <1454358000-13594-1-git-send-email-maxime.ripard@free-electrons.com>
 <56BB2D79.6090402@arm.com>
 <CABGGiswOKztmRT40w4t_7BD729WgM8ueLtOD-UF_wgMbmcg4cg@mail.gmail.com>
 <20160210143755.GE31506@lukather> <20160210163001.GG2632@leverpostej>
 <20160211100048.GK31506@lukather> <20160211114410.GA32535@leverpostej>
 <20160211170820.GP31506@lukather> <1455270030.3201.71.camel@pengutronix.de>
 <20160216084448.GE4344@lukather>
Message-ID: <20160216194004.2278.85138@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Maxime Ripard (2016-02-16 00:44:48)
> On Fri, Feb 12, 2016 at 10:40:30AM +0100, Lucas Stach wrote:
> > Am Donnerstag, den 11.02.2016, 18:08 +0100 schrieb Maxime Ripard:
> > [...]
> > > > > > Having code in mainline comes with responsibilities. One of those is to
> > > > > > keep said code working for existing users. Otherwise, why bother having
> > > > > > it in mainline at all?
> > > > > 
> > > > > None of our existing users ever complained.
> > > > 
> > > > I believe that in this case, Andre was complaining about this particular
> > > > breakage, unless I have misunderstood.
> > > > 
> > > > To be clear, I'm arguing for the strategy going forward. If no-one has
> > > > complained about the stuff broken up to this point, let's not waste time
> > > > restoring that.
> > > > 
> > > > Going forward we need to keep old DTBs supported.
> > > 
> > > I find that stand a bit dishonest.
> > > 
> > > You, DT maintainers, admit that you're not doing your job properly,
> > > and that burden relies on the platform maintainers? Or should I take
> > > it as you volunteering to maintain that code?
> > > 
> > > But ok. Let's do that. Make sure that the other platform maintainers
> > > are aware that this is the rule too though. I surely don't want to be
> > > alone in that boat.
> > 
> > FWIW: I always thought it's the platform maintainers job to enforce a
> > reasonable level of DT stability. I don't see how the DT maintainers
> > could provide the necessary in-depth review with every platform being
> > different in many subtle ways.
> > 
> > For the i.MX platform we actually enforced a baseline of DT stability by
> > shooting down patches that break DT stability for the sake of adding new
> > features, or when trying to put "fixes" into the DT, that could be
> > solved entirely inside the kernel.
> > 
> > Yes, mistakes happen and and we can not really prevent all breakage,
> > especially when the bindings were not strictly enough defined and board
> > DT writers may have interpreted them differently, but it is definitely
> > possible to keep DTs reasonably stable if the platform maintainers care
> > about that.
> > 
> > I strongly disagree with platform maintainers denying that duty, by
> > claiming that DTs won't be completely stable ever, so there is no reason
> > to even care.
> 
> A DT is either stable or not. If it is "reasonably" stable, then it's
> not.

Hi all,

I thought I'd pour some gasoline on this fire.

I'm happy for the one-node-per-clock bindings to be fully converted to a
clock-controller style binding, which is a clear compatibility break. In
other words, clock-cells = 0 bindings converted to clock-cells >= 1.

We really didn't have a clue about good DT bindings for a while, and
everyone keeps talking about being reasonable, etc. So with that in
mind, I propose that any clock binding written before 2015 should be
given amnesty to make these incompatible changes, so long as the
platform maintainers consent. Those stakeholders for sunxi are Maxime
Ripard, Chen-Yu Tsai and Emilio L?pez.

/me puts on flame retardant suit.

To be clear, I'm not in the business of telling SoCs to break
compatibility. That is thankfully not my choice to make and any platform
maintainer should have a long, difficult struggle when making that
decision. But I am supportive of merging those changes for clock
provider drivers if the platform maintainer decides to do so.

Regards,
Mike

> 
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
