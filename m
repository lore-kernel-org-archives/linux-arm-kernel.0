From: afzal@ti.com (Mohammed, Afzal)
Date: Mon, 28 Jan 2013 09:25:41 +0000
Subject: [PATCH v2 1/4] ARM: OMAP2+: dpll: round rate to closest value
In-Reply-To: <20130125222032.10623.47200@quantum>
References: <cover.1358937533.git.afzal@ti.com>
 <871e6890897534b6c3669e252f23bef5ff1247b6.1358937533.git.afzal@ti.com>
 <alpine.DEB.2.00.1301250816010.471@utopia.booyaka.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EA9388C@DBDE01.ent.ti.com>
 <20130125222032.10623.47200@quantum>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EA9446B@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Sat, Jan 26, 2013 at 03:50:32, Mike Turquette wrote:

> Is MULT_ROUND_UP doing the right thing for you in the clk_divider code?
> What is the clock rate requested of the parent PLL?  I just want to make
> sure that we're doing the right thing in the basic divider code.

Actually MULT_ROUND_UP made my life difficult earlier, and finally came up
with this solution instead of removing it.

It was something like 60000000 requested of PLL, for i = 1, but for other
values, it was something like 60000001, 60000002 etc.

Even if round rate rounds, I thought removing MULT_ROUND_UP would be ok,
couldn't spend time to understand fully rational behind it, and as it was
in generic code, kept away from doing it.

Regards
Afzal
