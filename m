From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 2 Jan 2012 15:00:21 +0100
Subject: snowball does not compile on linux-next
In-Reply-To: <4F01B763.4040201@linaro.org>
References: <4F0199CF.2070806@linaro.org>
 <CACRpkdbn6H_s8oC3VdqH2CoCZcPkc+hYccLE1UQJZnqB5eSf3Q@mail.gmail.com>
 <4F01B763.4040201@linaro.org>
Message-ID: <CACRpkdY+jRTdDP_i4-yw-gPTE57U6vG3nxPHw2cPRmzZF73bQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 2, 2012 at 2:55 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> it seems also the commit :
>
> commit c15def1cc30edeaa74a97205c936be82cdc86df6
> Author: Linus Walleij <linus.walleij@linaro.org>
> Date: ? Thu Dec 15 13:38:40 2011 +0100
>
> ? ?ARM: ux500: remove support for early silicon revisions
>
> ? ?The DB8500 ED (Early Drop) and V1 are only available inside of
> ? ?ST-Ericsson or partners, we have actively replaced and scrapped
> ? ?these prototypes. All Nova products on the open market (such as
> ? ?the Snowball board) are based on V2 and later ASIC variants.
> ? ?So let us focus on supporting the silicon that will be used and
> ? ?delete this to get a clear overview.
>
> ? ?Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> removed the U8500_PRCMU_TCDM_BASE_V1 macro definition but it is still
> used in drivers/mfd/db8500-prcmu.c

Yes, I have sent the patch removing it from the PRCMU driver
to the ARM SoC maintainers (you're on CC) so they can merge it
into their ux500 branch, I intended to do it this way (Sam already
ACK:ed it) but screwed up some way.

Yours,
Linus Walleij
