From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 May 2015 13:58:37 +0200
Subject: [PATCH v4 2/3] irqchip: GIC: Add support for irq_{get,
 set}_irqchip_state
In-Reply-To: <CAL85gmBrkonMcKdUVGmYx6zT3wSe-e2jPhnL_+Tkf3s4jsAiWg@mail.gmail.com>
References: <1426676484-21812-1-git-send-email-marc.zyngier@arm.com>
 <1426676484-21812-3-git-send-email-marc.zyngier@arm.com>
 <CAL85gmBrkonMcKdUVGmYx6zT3wSe-e2jPhnL_+Tkf3s4jsAiWg@mail.gmail.com>
Message-ID: <CACRpkdYffHJEzksc5mg7JZdwTzShGaQofAmbmn65=_V3ot04Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 4:25 AM, Feng Kan <fkan@apm.com> wrote:

> Marc:
>
> Sorry for top posting. It seems with GIC-400, the get_irqstate is not a reliable
> way of accessing the GPIO status. In our case, the gpio interrupt status can
> only be read correctly with the SPISR register. So it seems we have to go
> back to the old way of mapping the SPISR portion of the GIC in our GPIO
> driver. We wanted to ask you if that is acceptable since SPISR in not
> standard in all GIC, perhaps we can treat it differently.

As GPIO maintainer I am curious about what this is...

Can you describe the scenario where your GPIO (!) driver needs
to be poking around in the GIC SPISR?

Yours,
Linus Walleij
