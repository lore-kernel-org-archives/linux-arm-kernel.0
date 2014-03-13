From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Mar 2014 10:30:50 +0100
Subject: [PATCH v5 1/2] video: ARM CLCD: Add DT support
In-Reply-To: <53184C2E.3000807@ti.com>
References: <1394036606-17784-1-git-send-email-pawel.moll@arm.com>
 <53184C2E.3000807@ti.com>
Message-ID: <CACRpkdYBuxYko5JD5ZCfoQq+PeXtkKP9eprk9HM=ghW2YMoMuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 6, 2014 at 11:21 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Hi Pawel,
>
> On 05/03/14 18:23, Pawel Moll wrote:
>> This patch adds basic DT bindings for the PL11x CLCD cells
>> and make their fbdev driver use them.
>
> Is this an old HW, and presumably there won't be new users for it?

AFAICT ARM really like to re-synthesize this piece of HW in every
new reference design they make. Plus a number of manufacturers
have used it in elder systems.

> If
> yes, this is probably fine. If not, you might want to look at the video
> ports and endpoints, which is used by at least three not-yet-merged series:
>
> [PATCHv3 00/41] OMAPDSS: DT support v3
> [PATCH v5 00/11] imx-drm dt bindings
> [RFC PATCH v2 00/21] Add DSI display support for Exynos based boards
>
> Using bindings like that would be more future proof, even if the current
> driver doesn't use them.

I take it that it shouldn't matter if the driver is for framebuffer or
DRM (as was implied by some answer here) the hardware
description should be the same no matter what, so the more
furture-proof the better.

Yours,
Linus Walleij
