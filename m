From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 19 Jan 2016 09:09:01 +0100
Subject: [PATCH RFC 1/2] clk: sunxi: Add sun8i display support
In-Reply-To: <20160118190904.GP4581@lukather>
References: <cover.1452021349.git.moinejf@free.fr>
 <9cc33c3701844a07c43ee6c0c1072be4e2073cc1.1452021349.git.moinejf@free.fr>
 <20160118190904.GP4581@lukather>
Message-ID: <20160119090901.17c64bc4afb7095bb8bd291c@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Jan 2016 20:09:04 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> > +static const struct clk_ops clk_sun8i_pll3_fact_ops = {
> > +	.recalc_rate = sun8i_pll3_recalc_rate,
> > +	.round_rate = sun8i_pll3_round_rate,
> > +	.set_rate = sun8i_pll3_set_rate,
> > +};
> 
> We have the clk-factors stuff to handle this easily, could you use
> that instead ?

No, the sun6i/8i pll3 offers direct 297MHz and 270MHz.

> As part of my DRM patches, I've added a clk-display clock that can
> handle that easily.
> 
> And actually, as part of bringing up the display engine on the A33, I
> already did it:
> https://github.com/mripard/linux/commit/92b6843b5ee5b70cb2be3638df31d3eca28a4dba
> https://github.com/mripard/linux/commit/81e8ea74be5e72124eb584432bb79ff75f90d9ed

I don't remember any patch request from yours in the Linux
mailing-lists about these developments.

Otherwise, about this old RFC, Chen-Yu Tsai replied:

> > Add the clock types which are used by the sun8i family for video.
> 
> These clocks first appeared in the A31.
> 
> > Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> > ---
> >  drivers/clk/sunxi/Makefile            |   1 +
> >  drivers/clk/sunxi/clk-sun8i-display.c | 247 ++++++++++++++++++++++++++++++++++
> 
> Please split this into 2 patches, and 2 files: one for PLL3, named
> clk-sun6i-pll3.c, and one for the display mod clocks, named
> clk-sun6i-display.c

My new patch series about the H3 display was sent 4 days ago
(but not sure it reached the list linux-clk at vger.kernel.org
because of some non-ASCII characters).

-- 
A galon		|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
