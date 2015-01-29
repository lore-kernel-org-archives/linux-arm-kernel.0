From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 28 Jan 2015 18:31:03 -0800
Subject: [PATCH v2] clk: sunxi: fix sun6i PLL1 .recalc_rate() result
In-Reply-To: <CAGb2v66JHK9adf5gUKdiByke4OdtGN2KFKC1srx7q_4tARJU_g@mail.gmail.com>
References: <1422088959-23365-1-git-send-email-wens@csie.org>
 <20150124152944.GE8470@lukather> <20150128014105.22722.46052@quantum>
 <CAGb2v64GaYOXkMKcJa9EjxtCsjWJANOjmf2zbfP9Motn0+bMvw@mail.gmail.com>
 <20150128180141.22722.98983@quantum>
 <CAGb2v66JHK9adf5gUKdiByke4OdtGN2KFKC1srx7q_4tARJU_g@mail.gmail.com>
Message-ID: <20150129023103.22722.42964@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Chen-Yu Tsai (2015-01-28 13:57:14)
> On Wed, Jan 28, 2015 at 7:01 PM, Mike Turquette <mturquette@linaro.org> wrote:
> > Quoting Chen-Yu Tsai (2015-01-27 22:19:22)
> >> On Wed, Jan 28, 2015 at 2:41 AM, Mike Turquette <mturquette@linaro.org> wrote:
> >> > Quoting Maxime Ripard (2015-01-24 07:29:44)
> >> >> Hi Mike,
> >> >>
> >> >> On Sat, Jan 24, 2015 at 04:42:39PM +0800, Chen-Yu Tsai wrote:
> >> >> > PLL1 on sun6i has its N factor start from 1 (N = register value + 1).
> >> >> > Make the factors clk driver aware of this so clk_factors_recalc_rate()
> >> >> > gives the correct result.
> >> >> >
> >> >> > Cc: <stable@vger.kernel.org> # 3.12 9a5e6c7eb5cc clk: sunxi: Support factor
> >> >> > Cc: <stable@vger.kernel.org> # 3.12
> >> >> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> >>
> >> >> Could you queue this for 3.19?
> >> >
> >> > This is fixed in 76820fc in clk-next, destined for 3.20.
> >> >
> >> > Also I'm confused by the stable tags above. Looks like 9a5e6c7eb5cc was
> >> > merged for 3.16, not 3.12.
> >>
> >> I think so. I wasn't quite sure what the version number was
> >> supposed to be, the first version it is applicable? or the
> >> first version the specific patch was merged.
> >
> > Chen-Yu,
> >
> > I think that struct clk_factors_config did not have the n_start member
> > before 9a5e6c7eb5cc, so this patch could not apply without 9a5e6c7eb5cc.
> > That's from memory though, and I might be mis-remembering.
> 
> AFAIK the stable-commit doc explains the format above as cherry-picking
> 9a5e6c7eb5cc first, then applying this patch.

I just learned something new. I didn't know about the cherry-picking
format. That's cool.

> 
> > The fix is not for a new regression, thus it is going into 3.20 and I am
> > remiss to rebase my tree to add a stable tag. Can you submit this to
> > stable yourself after 3.20-rc1? I think the proper thing to do is to
> > reference this patch and the commitlog to show that it was fixed
> > upstream.
> 
> Sure. Also CC-ing Hans, as his name is on the patch for 3.20. :)

Thanks!

Regards,
Mike

> 
> ChenYu
> 
> > Regards,
> > Mike
> >
> >>
> >> ChenYu
> >>
> >> >>
> >> >> Thanks,
> >> >> Maxime
> >> >>
> >> >> --
> >> >> Maxime Ripard, Free Electrons
> >> >> Embedded Linux, Kernel and Android engineering
> >> >> http://free-electrons.com
