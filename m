From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Oct 2014 09:26:46 +0200
Subject: [PATCH v1 1/3] gpio: Add APM X-Gene standby GPIO controller driver
In-Reply-To: <CAL4ahLeZsT4KN22Jgxa8EJD8eEcWwN-wddCFvXY+8Yvb5hCGFA@mail.gmail.com>
References: <1412779948-28769-1-git-send-email-yvo@apm.com>
 <2334188.M3m5hnmS5j@wuerfel>
 <CAL4ahLeZsT4KN22Jgxa8EJD8eEcWwN-wddCFvXY+8Yvb5hCGFA@mail.gmail.com>
Message-ID: <2508938.qoNAztonL9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 October 2014 10:22:34 Y Vo wrote:
> APM:  There are 6 GPIOs which can support IRQ, they are fixed to use
> external IRQ from XGIC.  (The XGIC is based on the ARM Generic
> Interrupt Controller Architecture Specification, Architecture version
> 2.0, The XGIC provides the mechanism to collect interrupt requests
> (IRQs) from both on-chip as well as off-chip sources and deliver them
> to the multiple X-Gene1 cores within the X-Gene1 processor),  So there
> are no way to read the GPIO DS when configure as an interrupt. They
> are specific GPIO for boot another boot chip in X-Gene which can
> access when boot up. So this is hardwire in the GPIO block.
> GPIO_DS8 ---> External IRQ0 (XGIC40)
> GPIO_DS9 ---> External IRQ1 (XGIC41)
> ...
> GPIO_DS13 ---> External IRQ5(XGIC45)

Could you read the status of the external IRQ line using irq_get_pending()
or another public interface?

If not, we may have to add an interface for doing this.

	Arnd
