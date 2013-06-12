From: dianders@chromium.org (Doug Anderson)
Date: Wed, 12 Jun 2013 14:50:29 -0700
Subject: [PATCH v4 1/6] clk: samsung: Use clk->base instead of directly
 using clk->con0 for PLL3xxx
In-Reply-To: <1501124.EVQA8KO0ic@flatron>
References: <1370272196-4346-1-git-send-email-yadi.brar@samsung.com>
 <1370272196-4346-2-git-send-email-yadi.brar@samsung.com>
 <CAD=FV=VTLkH9oDqr263Kyv=wCEbuQ40VL7mtC73SCMt20NPwgQ@mail.gmail.com>
 <1501124.EVQA8KO0ic@flatron>
Message-ID: <CAD=FV=XKjYBzgBwY+CnUZyzyBzgGN88Y39n=tABgAH5aU3gSkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz,

On Wed, Jun 12, 2013 at 2:19 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hmm, if done properly, it could simplify PLL registration in SoC clock
> initialization code a lot.
>
> I'm not sure if this is really the best solution (feel free to suggest
> anything better), but we could put PLLs in an array, like other clocks,
> e.g.
>
>         ... exynos4210_pll_clks[] = {
>                 CLK_PLL45XX(...),
>                 CLK_PLL45XX(...),
>                 CLK_PLL46XX(...),
>                 CLK_PLL46XX(...),
>         };
>
> and then just call a helper like
>
>         samsung_clk_register_pll(exynos4210_pll_clks,
>                         ARRAY_SIZE(exynos4210_pll_clks));

Something like that looks like what I was thinking.  I'd have to see
it actually coded up to see if there's something I'm missing that
would prevent us from doing that, but I don't see anything.

-Doug
