From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 5 Jun 2014 10:47:45 +0200
Subject: [PATCH] clk: st: avoid build warnings
In-Reply-To: <10904360.yBfDy9q35b@wuerfel>
References: <10904360.yBfDy9q35b@wuerfel>
Message-ID: <53902EB1.1050208@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 06/04/2014 05:32 PM, Arnd Bergmann wrote:
> This driver prints some variables in debugging output when
> their contents are undefined.
>
> drivers/clk/st/clkgen-fsyn.c: In function 'quadfs_pll_fs660c32_round_rate':
> drivers/clk/st/clkgen-fsyn.c:419:93: warning: 'params.sdiv' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    pr_debug("%s: %s new rate %ld [sdiv=0x%x,md=0x%x,pe=0x%x,nsdiv3=%u]\n",
>                                                                                               ^
> drivers/clk/st/clkgen-fsyn.c:414:16: note: 'params.sdiv' was declared here
>    struct stm_fs params;
>                  ^
>
> This removes them from the output.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>

You can add my:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks!
Maxime
