From: bjorn@kryo.se (Bjorn Andersson)
Date: Thu, 5 Feb 2015 15:33:21 -0800
Subject: [PATCH v3 1/3] genirq: Allow the irqchip state of an IRQ to be
 save/restored
In-Reply-To: <1420653062-23361-2-git-send-email-marc.zyngier@arm.com>
References: <1420653062-23361-1-git-send-email-marc.zyngier@arm.com>
 <1420653062-23361-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAJAp7Oju0yD14Y53T7xC2D9oHUANyUs2BT42S4g=iJ1md76TGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 7, 2015 at 9:51 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> There is a number of cases where a kernel subsystem may want to
> introspect the state of an interrupt at the irqchip level:
>
> - When a peripheral is shared between virtual machines,
>   its interrupt state becomes part of the guest's state,
>   and must be switched accordingly. KVM on arm/arm64 requires
>   this for its guest-visible timer
> - Some GPIO controllers seem to require peeking into the
>   interrupt controller they are connected to to report
>   their internal state
>
> This seem to be a pattern that is common enough for the core code
> to try and support this without too many horrible hacks. Introduce
> a pair of accessors (irq_get_irqchip_state/irq_set_irqchip_state)
> to retrieve the bits that can be of interest to another subsystem:
> pending, active, and masked.
>
> - irq_get_irqchip_state returns the state of the interrupt according
>   to a parameter set to IRQCHIP_STATE_PENDING, IRQCHIP_STATE_ACTIVE,
>   IRQCHIP_STATE_MASKED or IRQCHIP_STATE_LINE_LEVEL.
> - irq_set_irqchip_state similarly sets the state of the interrupt.
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Tested-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Any update on the status of this?

I would like to be able to move ahead with the pinctrl driver for the
Qualcomm PM8921 pmic, that depends on this being in place.

Regards,
Bjorn
