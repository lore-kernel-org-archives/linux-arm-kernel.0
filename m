From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 14 Jul 2015 23:14:45 +0200
Subject: [PATCH v2 01/13] ARM: kill off set_irq_flags usage
In-Reply-To: <1436711211-18223-2-git-send-email-robh@kernel.org> (Rob
 Herring's message of "Sun, 12 Jul 2015 09:26:39 -0500")
References: <1436711211-18223-1-git-send-email-robh@kernel.org>
 <1436711211-18223-2-git-send-email-robh@kernel.org>
Message-ID: <87pp3ujvay.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh@kernel.org> writes:

> set_irq_flags is ARM specific with custom flags which have genirq
> equivalents. Convert drivers to use the genirq interfaces directly, so we
> can kill off set_irq_flags. The translation of flags is as follows:
>
> IRQF_VALID -> !IRQ_NOREQUEST
> IRQF_PROBE -> !IRQ_NOPROBE
> IRQF_NOAUTOEN -> IRQ_NOAUTOEN
>
> For IRQs managed by an irqdomain, the irqdomain core code handles clearing
> and setting IRQ_NOREQUEST already, so there is no need to do this in
> .map() functions and we can simply remove the set_irq_flags calls. Some
> users also set IRQ_NOPROBE and this has been maintained although it is not
> clear that is really needed. There appears to be a great deal of blind
> copy and paste of this code.

As this works for several pxa boards :
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

-- 
Robert
