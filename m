From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 21 Jun 2016 11:40:44 +0200
Subject: [PATCH v2 00/15] clk: sunxi: introduce "modern" clock support
In-Reply-To: <20160607204154.31967-1-maxime.ripard@free-electrons.com>
References: <20160607204154.31967-1-maxime.ripard@free-electrons.com>
Message-ID: <20160621114044.811e2136eca5c1d863d79ac6@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  7 Jun 2016 22:41:39 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> The current code has been tested on the H3 and an Orange Pi PC,
> including making sure that MMC still works, so the general approach
> seems ok.
> 
> Let me know what you think,

Hi Maxime,

I used your code in both the H3 and A83T, and it worked fine for the
current clocks.

But I had some problems with some features as the 'mode select' in the
A83T MMC2 clock.
Also, I think that you did not go far enough in the changes.
For example, most clock gates as well as most resets could be removed
from the DT and automatically set/de-asserted on clock prepare or clock
enable.

So, I am rewriting a generic sunxi clock driver into one file (about
1000 lines) and I have the full (simpler and clearer) description of
the H3 and the A863T clocks.

Coding is not finished yet. I will submit a RFC as soon as I will have
something working.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
