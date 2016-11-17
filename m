From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Nov 2016 23:35:07 +0100
Subject: [GIT PULL] Allwinner clock changes for 4.10
In-Reply-To: <20161116192656.GJ25626@codeaurora.org>
References: <20161115212615.lm3guceyfmdjnhfp@lukather>
 <20161116192656.GJ25626@codeaurora.org>
Message-ID: <20161117223507.bdpwlmfzprv7vbhd@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 11:26:56AM -0800, Stephen Boyd wrote:
> On 11/15, Maxime Ripard wrote:
> > Hi Mike, Stephen,
> > 
> > Please pull the following patches for the next merge window.
> > 
> > Thanks!
> > Maxime
> > 
> > The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> > 
> >   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> > 
> > are available in the git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git sunxi-clk-for-4.10
> > 
> > for you to fetch changes up to 0f6f9302b819ca352cfd4f42c18ec08d521f9cae:
> > 
> >   clk: sunxi-ng: sun8i-h3: Set CLK_SET_RATE_PARENT for audio module clocks (2016-11-11 21:47:41 +0100)
> 
> Pulled into clk-next, but I get the following grumbles...
> 
> ERROR: space prohibited before that ',' (ctx:WxW)
> #282: FILE: drivers/clk/sunxi-ng/ccu-sun50i-a64.c:206:
> +                                            "pll-cpux" , "pll-cpux" };
>                                                         ^
> 
> ERROR: space prohibited before that ',' (ctx:WxW)
> #289: FILE: drivers/clk/sunxi-ng/ccu-sun50i-a64.c:213:
> +                                            "axi" , "pll-periph0" };
>                                                    ^
> 
> ERROR: space prohibited before that ',' (ctx:WxE)
> #325: FILE: drivers/clk/sunxi-ng/ccu-sun50i-a64.c:249:
> +                                            "pll-periph0-2x" ,
>                                                               ^
> 
> ERROR: space prohibited before that ',' (ctx:WxW)
> #333: FILE: drivers/clk/sunxi-ng/ccu-sun50i-a64.c:257:
> +static const char * const ahb2_parents[] = { "ahb1" , "pll-periph0" };
>                                                      ^
> 
> drivers/clk/sunxi-ng/ccu-sun50i-a64.c:160:16: warning: symbol 'pll_mipi_clk' was not declared. Should it be static?
> drivers/clk/sunxi-ng/ccu-sun50i-a64.c:507:16: warning: symbol 'tcon1_clk' was not declared. Should it be static?
> 
> I'll go fix them this time, but please be more careful next time.

Ugh, sorry it slipped through...

Thanks for fixing it,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161117/a7bdc5d6/attachment.sig>
