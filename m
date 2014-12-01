From: dianders@chromium.org (Doug Anderson)
Date: Mon, 1 Dec 2014 15:04:59 -0800
Subject: [PATCH] ARM: rockchip: Convert resume code to C
In-Reply-To: <20141201225057.GA11285@n2100.arm.linux.org.uk>
References: <1417461694-5129-1-git-send-email-dianders@chromium.org>
 <20141201225057.GA11285@n2100.arm.linux.org.uk>
Message-ID: <CAD=FV=VT7gr504-ZgWPfha+40XDX5eShkzZ36bg=-4Oub1S27w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russel,

On Mon, Dec 1, 2014 at 2:50 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> What I see here is a load of complexity which achieves very little.
> The result doesn't get rid of much assembly, but it does make stuff
> more complicated.  And the diffstat speaks volumes about this:
>
>  10 files changed, 275 insertions(+), 94 deletions(-)
>
> There's a lot of words in the description, but it's missing the most
> important bit: why do we want to take this approach - what benefits
> does it bring?

Sure.  I guess the most important words in the description are:

> We convert the existing assembly resume code into C as proof that this
> works and to prepare for linking in SDRAM reinit code.

I can't say that the SDRAM reinit code is ready for prime time yet,
but you can get a preview of what it could look like at:

https://chromium-review.googlesource.com/#/c/227366/25/arch/arm/mach-rockchip/embedded/rk3288_ddr_resume.c

Adding that code in assembly seems like a very, very bad idea.
Certainly my patch could wait until the DDR code is ready to be posted
upstream if that made sense.  One advantage of waiting is that it's
possible that the DDR code might end up moving elsewhere if it made
sense to have it part of a memory controller driver or something like
that.

-Doug
