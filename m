From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 10 Feb 2016 18:04:20 +0100
Subject: [PATCH v4] clk: sunxi: Refactor A31 PLL6 so that it can be reused
In-Reply-To: <20160210125333.GC31506@lukather>
References: <1454358000-13594-1-git-send-email-maxime.ripard@free-electrons.com>
 <20160204120507.GC4270@lukather>
 <20160204162545.f806fcb64a826d2c3313985b@free.fr>
 <20160210125333.GC31506@lukather>
Message-ID: <20160210180420.0968c2018bf5fbe54a28a505@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Feb 2016 13:53:33 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> > I don't agree:
> > - you changed the DTs of many SoCs without any valid reason,
> 
> I did give you a significant number of reasons [1]. The fact that you
> chose to ignore them is up to you.

Sorry, I don't see any reason for changing the DT definition of the pll6.
The clock is named "pll6" with "#clock-cells = <1>;" in all DTs,
and it works as it is.
If you want an other clock as "pll8", with the same HW description,
you must add new code for this clock.

> Except that it doesn't match the hardware and that the parenthood
> relationship is inversed. The pll6 output is 24 MHz * n * k / 2, as
> seen in any datasheet that uses it. Your clock driver doesn't
> represent that fact.

The datasheet says that the pll6x2 output is 24 MHz * n * k, then, if
I remember correctly my lessons at primary school, defining pll6 as
(pll6x2 / 2) gives 24 MHz * n * k / 2 as the pll6 output. No?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
