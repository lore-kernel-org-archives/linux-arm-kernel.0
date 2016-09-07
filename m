From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 7 Sep 2016 16:54:41 +0800
Subject: [PATCH v4 4/8] dts: sun8i-h3: move uart1 pinmux/peripheral
 assocation to DSTI
In-Reply-To: <1473235141-12768-5-git-send-email-jorik@kippendief.biz>
References: <1473235141-12768-1-git-send-email-jorik@kippendief.biz>
 <1473235141-12768-5-git-send-email-jorik@kippendief.biz>
Message-ID: <CAGb2v64PWJdeqBcKDJe05a6yct3_JcztSR9GDH4YXBCny9zb5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 7, 2016 at 3:58 PM,  <jorik@kippendief.biz> wrote:
> From: Jorik Jonker <jorik@kippendief.biz>
>
> Users using this UART without RTS/CTS should override the association in
> their board specific DTS. All (1) board using this UART uses RTS/CTS, so
> this breaks nothing.

I'd prefer we only do this for peripherals that have absolutely one
possible setting, like RSB, or I2C with only one group of pins.
UARTs with 2/4/8 pin configurations don't fall in this category.

ChenYu
