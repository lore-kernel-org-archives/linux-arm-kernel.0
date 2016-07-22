From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Jul 2016 17:02:26 +0200
Subject: [PATCH 1/2] ARM: realview: Fix PBX-A9 cache description
In-Reply-To: <dbf8749c4af9aa5ffb85e961b7ae09ffeefa7f2a.1468583959.git.robin.murphy@arm.com>
References: <dbf8749c4af9aa5ffb85e961b7ae09ffeefa7f2a.1468583959.git.robin.murphy@arm.com>
Message-ID: <CACRpkdYTp2V_qR80ykn_3SxaBVg9mj71OZmU=T8knMZqo_i2rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 2:19 PM, Robin Murphy <robin.murphy@arm.com> wrote:

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
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Sorry for screwing things up! :(

Patch applied with Rutland's Test tag, I will carry this to ARM SoC as a fix.

Yours,
Linus Walleij
