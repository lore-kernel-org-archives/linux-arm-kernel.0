From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 4 Aug 2011 17:57:03 +0200
Subject: [PATCH 12/12] ARM: Remove mach-*/include/mach/timex.h
In-Reply-To: <20110804135445.GJ1019@plexity.net>
References: <cover.1312455035.git.dsaxena@linaro.org>
	<20110804135445.GJ1019@plexity.net>
Message-ID: <CACRpkdYepxshZr-UuA9UU_d--rsYFV648FbdO5nM36gZYZMMkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 4, 2011 at 3:54 PM, Deepak Saxena <dsaxena@linaro.org> wrote:

> We no longer use the global LATCH definition to drive
> any platform-specific timers so we can remove the
> timex.h files from all sub-arch include directories.
>
> We still need to keep an ARM CLOCK_TICK_RATE due to
> jiffies.h depending on it to build but that will be
> removed in the future once all non-ARM references to
> LATCH are also removed.
>
> Signed-off-by: Deepak Saxena <dsaxena@linaro.org>

This confusing define has bitten me in the past so I'm very happy
to get rid of it. So for ux500, u300 and nomadik:

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
