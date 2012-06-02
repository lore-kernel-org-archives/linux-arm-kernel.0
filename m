From: will.deacon@arm.com (Will Deacon)
Date: Sat, 2 Jun 2012 17:50:00 +0100
Subject: [PATCH v3] ARM: at91: aic can use fast eoi handler type
In-Reply-To: <1338545298-6687-1-git-send-email-ludovic.desroches@atmel.com>
References: <1338545298-6687-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20120602165000.GB14903@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ludovic,

I have some minor corrections to the commit message but the code looks fine
now. Thanks!

On Fri, Jun 01, 2012 at 11:08:18AM +0100, ludovic.desroches at atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> The Advanced Interrupt Controller allows to use the fast EOI handler type.

allows us to use

> It lets remove the Atmel specific workaround into arch/arm/kernel/irq.c used

lets us remove the Atmel specific workaround in

> to indicate to the AIC the end of the interrupt treatment.
> Removing irq_finish from handle_IRQ involves to manage it in the gpio irq
> handler.

I don't understand this final sentence. The GPIO changes are just mirroring
the change of flow control so I don't think you need to comment on them.

> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
