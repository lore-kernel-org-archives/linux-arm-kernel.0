From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Aug 2016 22:46:39 +0200
Subject: [PATCH] ARM: dts: realview: Fix PBX-A9 cache description
In-Reply-To: <1470830537-12307-1-git-send-email-linus.walleij@linaro.org>
References: <1470830537-12307-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <4141561.enkVqu9s0z@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 10, 2016 2:02:17 PM CEST Linus Walleij wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> Clearly QEMU is very permissive in how its PL310 model may be set up,
> but the real hardware turns out to be far more particular about things
> actually being correct. Fix up the DT description so that the real
> thing actually boots:
> 
> - The arm,data-latency and arm,tag-latency properties need 3 cells to
>   be valid, otherwise we end up retaining the default 8-cycle latencies
>   which leads pretty quickly to lockup.
> - The arm,dirty-latency property is only relevant to L210/L220, so get
>   rid of it.
> - The cache geometry override also leads to lockup and/or general
>   misbehaviour. Irritatingly, the manual doesn't state the actual PL310
>   configuration, but based on the boardfile code and poking registers
>   from the Boot Monitor, it would seem to be 8 sets of 16KB ways.
> 
> With that, we can successfully boot to enjoy the fun of mismatched FPUs...
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this directly for fixes. I had
> queued it for worries of clashing with other updates, but I think
> it will be fine, and it needs to go in for v4.8.
> 
Applied to fixes, thanks

	Arnd
