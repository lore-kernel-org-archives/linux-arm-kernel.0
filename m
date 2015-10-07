From: p.fedin@samsung.com (Pavel Fedin)
Date: Wed, 07 Oct 2015 15:14:16 +0300
Subject: PING: [PATCH v4 TRIVIAL 1/2] ARM: Enable GICv2m on 32-bit virt
 machine
In-Reply-To: <20151007102313.GG21513@n2100.arm.linux.org.uk>
References: <017801d100dc$77fe3a90$67faafb0$@samsung.com>
 <20151007102313.GG21513@n2100.arm.linux.org.uk>
Message-ID: <020c01d100f9$b02d23a0$10876ae0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> I know we have MSI-using platforms working on 32-bit ARM at the moment,
> which brings up the question about msi.h in your patch, and what are
> the implications for the existing MSI using platforms of having
> PCI_MSI_IRQ_DOMAIN enabled in a multiplatform kernel.

 I have just tested, what happens if i disable PCI_MSI_IRQ_DOMAIN. No, it's not going to work,
irq-gic-v2m.c requires MSI domain API. Looks like old MSI drivers do not use IRQ domains and just
transparently handle translation of MSIs to SPI IDs.
 At this point unfortunately i cannot do anything else, because i don't have any of those platforms,
so cannot test. Added also Christoffer to cc. Hopefully somebody in ARM or Linaro gets interested.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
