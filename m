From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 16 May 2016 15:15:01 +0200
Subject: [PATCH 03/16] clk: sunxi-ng: Add fixed factor clock support
In-Reply-To: <CAGb2v65LcXnMj7B-0q2MYESM9vGd9k-yChjvFdX--EivSYdVJg@mail.gmail.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-4-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v65LcXnMj7B-0q2MYESM9vGd9k-yChjvFdX--EivSYdVJg@mail.gmail.com>
Message-ID: <20160516151501.0dccc69384c08d6d646acac1@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 9 May 2016 18:05:20 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> > +}
> > +
> > +static long ccu_fixed_factor_round_rate(struct clk_hw *hw,
> > +                                       unsigned long rate,
> > +                                       unsigned long *parent_rate)
> > +{
> > +       struct ccu_fixed_factor *fix = hw_to_ccu_fixed_factor(hw);
> > +
> > +       return *parent_rate / fix->div * fix->mult;
> 
> Why is this the other way around? With integer math it shouldn't be
> interchangeable. (Though it seems clk_fixed_factor does the same...)
> 
> Also, clk_fixed_factor handles CLK_SET_RATE_PARENT. Do we need to do the
> same here?

Agree. Otherwise, sound in the H3 does not work.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
