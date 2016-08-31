From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Wed, 31 Aug 2016 11:28:36 +0000
Subject: [Fwd: Re: [PATCH v2 1/6] clk: tegra: add TEGRA20_CLK_NOR to init
 table]
In-Reply-To: <CALw8SCUHjFAr7RT3UCOkZ9W4Uf=nLHr2F3A_DqKiw1q_LOXDrg@mail.gmail.com>
References: <1472569308.5703.22.camel@toradex.com>
 <1472627744.31008.2.camel@toradex.com>
 <CALw8SCUHjFAr7RT3UCOkZ9W4Uf=nLHr2F3A_DqKiw1q_LOXDrg@mail.gmail.com>
Message-ID: <1472642915.31008.32.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-08-31 at 11:47 +0200, Mirza Krak wrote:
> I'm just curious where that 92 MHz came from. According to the
> > Tegra 2
> > Interface Design Guide up to 133 MHz should actually be possible.
> The maximum rates for both T20 and T30 are values that are set as
> maximum in the downstream L4T kernel.
> 
> In tegra2_clocks.c:
> PERIPH_CLK("nor", "tegra-nor", NULL, 42, 0x1d0, 0x31E, 92000000,
> mux_pllp_pllc_pllm_clkm, MUX | DIV_U71), /* requires min voltage */
> 
> And in tegra3_clocks.c
> PERIPH_CLK("nor", "tegra-nor", NULL, 42, 0x1d0, 127000000,
> mux_pllp_pllc_pllm_clkm, MUX | DIV_U71), /* requires min voltage */
> 
> I looked up the commit in the downstream kernel that added the "nor"
> clock, it does not mention reason behind the maximal rates. Author
> was
> Manoj Chourasia, added him to CC.

Let's see whether we do get any feedback from him.

Nonetheless it may be good to add this information to the commit
message so should somebody ever feel the same curiosity like I did he
would at least know where it initially came from.

> I actually do not have the Tegra2 Interface Design Guide, do not know
> if I can get access to it.

I guess that one is only accessible under NDA. We could of course try
to get one in place for you but I can't promise you anything.

> Best Regards
> Mirza

Thanks, Mirza
