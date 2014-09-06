From: emilio@elopez.com.ar (=?windows-1252?Q?Emilio_L=F3pez?=)
Date: Sat, 06 Sep 2014 12:55:18 -0300
Subject: [PATCH] clk: sunxi: add correct divider table for sun4i-apb0 clock
In-Reply-To: <1409985910-30737-1-git-send-email-wens@csie.org>
References: <1409985910-30737-1-git-send-email-wens@csie.org>
Message-ID: <540B2E66.1020509@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 06/09/14 a las 03:45, Chen-Yu Tsai escibi?:
> The sun4i-apb0 clock, as found on all platforms using it, is a
> power-of-two-based divider clock, with a special divider of 2
> for value 0.
>
> This was causing the clock framework to incorrectly calculate
> the clock rate for apb1 and related modules on sun6i and sun8i.
> On sun[4/5/7]i, u-boot SPL configures the divider with value 1
> for /2 divider, so no suprises there.
>
> This patch adds a proper divider table for it, so the correct
> clock rate can be calculated.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

 From a quick look at the A10 manual,

Acked-by: Emilio L?pez <emilio@elopez.com.ar>

I'll see about testing it on hardware today/tomorrow

Thanks!

Emilio
