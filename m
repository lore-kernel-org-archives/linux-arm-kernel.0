From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 6 Dec 2013 23:50:03 +0100
Subject: [PATCH v2 1/6] ARM: brcmstb: add infrastructure for ARM-based
 Broadcom STB SoCs
In-Reply-To: <CAGVrzcYha7y2pQ-tFtu19ZAN3DVWVAJOt_0UPEU6e5KfuBnMjA@mail.gmail.com>
References: <1385511748-27869-1-git-send-email-marc.ceeeee@gmail.com>
 <201312052107.07197.arnd@arndb.de>
 <CAGVrzcYha7y2pQ-tFtu19ZAN3DVWVAJOt_0UPEU6e5KfuBnMjA@mail.gmail.com>
Message-ID: <201312062350.04133.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 December 2013, Florian Fainelli wrote:
> This BCHP_IRQ0 register is kind of special and only acts as an
> interrupt forwarder. Not enabling the IRQEN bit will prevent the UART
> interrupts to be raised at the GIC level. Now that I think about this
> some more, we might just go with some sort of special node which
> contains a mask of the interrupts and apply this mask to the
> corresponding hardware register? There is no need for this to be
> modelled as an interrupt controller because this really is not a real
> one.

Right, that would work. Unfortunately we need it rather early (before
the console code starts), so I'm not sure where to best put the code
for it. Any suggestions?

What else is in the same 4K register region?

	Arnd
