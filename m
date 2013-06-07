From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Jun 2013 15:13:19 +0200
Subject: [PATCH 2/4] mfd: dbx500-prcmu: Correctly reorder PRCMU clock
 identifiers
In-Reply-To: <1370517676-10909-3-git-send-email-lee.jones@linaro.org>
References: <1370517676-10909-1-git-send-email-lee.jones@linaro.org>
 <1370517676-10909-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYLB-_JjEd69vVub_Z3L+avQRrFBt1fGuyR0D_owcLWvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 6, 2013 at 1:21 PM, Lee Jones <lee.jones@linaro.org> wrote:

> ... as stipulated by the Hardware Specification document.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I think you need Ulf (as ux500 clock author) and Loic (as PRCMU
developer) to have a look at this.

> -enum prcmu_clock {
> -       PRCMU_SGACLK,
(...)
> +#define ARMCLK                 0
> +#define PRCMU_ACLK             1
(...)

It seems the enum and the defines want to do two different things?

The first is a kernel-internal representation of the clocks, whereas
the latter is a HW-centric representation for a certain PRCMU
variant (I guess?)

Does one actually exclude the other?

Yours,
Linus Walleij
