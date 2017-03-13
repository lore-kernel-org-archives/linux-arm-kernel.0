From: olof@lixom.net (Olof Johansson)
Date: Mon, 13 Mar 2017 16:04:22 -0700
Subject: [PATCH 4/4] RFT: irqchip: replace moxa with ftintc010
In-Reply-To: <20170311231505.16056-1-linus.walleij@linaro.org>
References: <20170311231505.16056-1-linus.walleij@linaro.org>
Message-ID: <20170313230422.GI13064@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 12, 2017 at 12:15:05AM +0100, Linus Walleij wrote:
> The Moxa Art interrupt controller is very very likely just an instance
> of the Faraday FTINTC010 interrupt controller from Faraday Technology.
> An indication would be its close association with the FA526 ARM core
> and the fact that the register layout is the same.
> 
> The implementation in irq-moxart.c can probably be right off replaced
> with the irq-ftintc010.c driver by adding a compatible string, selecting
> this irqchip from the machine and run.
> 
> As a bonus we have an irqchip driver supporting high/low and
> rising/falling edges for the Moxa Art, and shared code with the Gemini
> platform.
> 
> Cc: arm at kernel.org
> Cc: Jonas Jensen <jonas.jensen@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
