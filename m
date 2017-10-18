From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 18 Oct 2017 17:48:24 +0100
Subject: [PATCH v4 0/2] irqchip: meson: add support for the gpio interrupt
 controller
In-Reply-To: <20170918134610.17743-1-jbrunet@baylibre.com> (Jerome Brunet's
 message of "Mon, 18 Sep 2017 15:46:07 +0200")
References: <20170918134610.17743-1-jbrunet@baylibre.com>
Message-ID: <87shegieqv.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18 2017 at  3:46:07 pm BST, Jerome Brunet <jbrunet@baylibre.com> wrote:
> This patch series adds support for the GPIO interrupt controller found on
> Amlogic's meson SoC families.
>
> Unlike what the name suggests, this controller is not part of the SoC
> GPIO subsystem. It is a separate controller which can watch almost all
> gpio pads of the SoC and generate and interrupt from it. "Almost" because
> there are always exceptions and some specific gpios (TEST_N) lack this
> capability.
>
> Hardware wise, the controller is a 256 to 8 router with a filtering block
> to select edge or level input and the polarity of the signal. We can't
> setup the filtring to generate a signal on both the high and low polarity
> so, ATM, IRQ_TYPE_EDGE_BOTH is not supported.
>
> The number of interrupt line routed to the controller depends on the SoC,
> and essentially the total number of GPIO available on the different gpio
> controllers of the SoC.
>
> This series has been tested on Amlogic S905-P200 board with the front
> panel power button. Also tested on the Nanopi-k2 with the ethernet PHY
> interrupt pin.
>
> This work is derived from the previous work of Carlo Caione [1].

Queued for 4.15.

	M.
-- 
Jazz is not dead, it just smell funny.
