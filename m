From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Dec 2012 13:40:20 +0100
Subject: Coresight bus and drivers from CodeAurora
Message-ID: <CACRpkdYeFw3YqYqgNAKUv1U4edyzzUa9x6xBSoBU4BbBoc6q5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratik,

recently my colleague Magnus (@ST-Ericsson) found this bus and
implementations for the ARM Coresight and drivers for the ARM Coresight
blocks ETB, ETM, Funnel, Replicator, STM, TMC and TPIU. The
code is here:
https://www.codeaurora.org/gitweb/quic/le/?p=kernel/msm.git;a=tree;f=drivers/coresight;h=f0221ea9a55c1e8bcd63f36ec28abb6d5406e63d;hb=refs/heads/msm-3.4

What is your intention with this? Do you have any intention to mainline?

We can see it has references to Qualcomm in the device tree strings even
though they are ARM Coresight HW blocks, for example, so some changes
are likely necessary, and such bindings should pass the devicetree-discuss
list.

Will: what is ARM Ltd. position on these blocks and their drivers? Any plans
from your side?

Douglas: look another STM driver... :-)

John Stultz has recently been working on some PTM extensions
submitted by Arve Hj?nnev?g as well, relating quite closely to this.

The design is nice, but maybe this is one of the few cases where the
drivers should actually live under arch/arm/common/* or similar.

Yours,
Linus Walleij
