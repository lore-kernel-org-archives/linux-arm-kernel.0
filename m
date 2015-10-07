From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Oct 2015 17:02:38 +0200
Subject: Irq domain for legacy interrupts
In-Reply-To: <loom.20151007T164737-541@post.gmane.org>
References: <loom.20151007T164737-541@post.gmane.org>
Message-ID: <41520723.9CcSmQjLSU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 October 2015 14:53:03 bharat kumar gogada wrote:
> why do we need a irq domain for legacy interrupts ?

You need an irq domain if you want to refer to the interrupts from
DT, otherwise you have no way to describe them.

> Do we need any specific
> parameter in device tree other that interrupt-map, interrupt-map-mask, for
> handling with irq domain ?

no.

> when will the .map method in struct irq_domain_ops get invoked for legacy
> interrupts ?

when the interrupt gets mapped ;-)

This should happen whenever the first PCIe device starts using non-MSI
interrupts.

	Arnd
