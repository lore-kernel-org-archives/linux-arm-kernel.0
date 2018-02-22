From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 22 Feb 2018 11:38:19 +0000
Subject: [PATCH v3] arm64: Add support for new control bits CTR_EL0.DIC
 and CTR_EL0.IDC
In-Reply-To: <0eb2d23b-cf96-c7ff-9820-16ed113f4862@arm.com>
References: <1519220946-13901-1-git-send-email-shankerd@codeaurora.org>
 <20180221150929.hkvtwu4fgfeis5cy@salmiak>
 <5be4684b-e2d8-1b3b-4c96-03c7dae0b619@codeaurora.org>
 <0eb2d23b-cf96-c7ff-9820-16ed113f4862@arm.com>
Message-ID: <20180222113818.6cknpwfbed2ab2nd@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 04:51:40PM +0000, Robin Murphy wrote:
> On 21/02/18 16:14, Shanker Donthineni wrote:
> [...]
> > > > @@ -1100,6 +1114,20 @@ static int cpu_copy_el2regs(void *__unused)
> > > >   		.enable = cpu_clear_disr,
> > > >   	},
> > > >   #endif /* CONFIG_ARM64_RAS_EXTN */
> > > > +#ifdef CONFIG_ARM64_SKIP_CACHE_POU
> > > > +	{
> > > > +		.desc = "DCache clean to POU",
> > > 
> > > This description is confusing, and sounds like it's describing DC CVAU, rather
> > > than the ability to ellide it. How about:
> > 
> > Sure, I'll take your suggestion.
> 
> Can we at least spell "elision" correctly please? ;)

Argh. Yes.

> Personally I read DIC and IDC as "D-cache to I-cache coherency" and "I-cache
> to D-cache coherency" respectively (just my interpretation, I've not looked
> into the spec work for any hints of rationale), but out loud those do sound
> so poorly-defined that keeping things in terms of the required maintenance
> probably is better.

So long as we have (IDC) and (DIC) in the text to avoid ambiguity, I'm
not that worried either way.

Thanks,
Mark.
