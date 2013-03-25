From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Mar 2013 10:53:11 +0000
Subject: [PATCH 4/8] ARM: sirf: enable sparse IRQ
In-Reply-To: <CAGsJ_4xUjH_kcMv4=r8-duZFR9Xz25V-KZRGwv0SM8pUAnfdyQ@mail.gmail.com>
References: <1363779679-16880-1-git-send-email-arnd@arndb.de>
 <1363779679-16880-5-git-send-email-arnd@arndb.de>
 <CAGsJ_4xUjH_kcMv4=r8-duZFR9Xz25V-KZRGwv0SM8pUAnfdyQ@mail.gmail.com>
Message-ID: <201303251053.11854.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 March 2013, Barry Song wrote:
> > -#define SIRFSOC_INTENAL_IRQ_START  0
> > -#define SIRFSOC_INTENAL_IRQ_END    127
> > -#define SIRFSOC_GPIO_IRQ_START     (SIRFSOC_INTENAL_IRQ_END + 1)
> > -#define NR_IRQS      288
> 
> after dropping NR_IRQS and enabling SPARSE_IRQ, should we add .nr_irqs
> = 288 to MACHINE_START(ATLAS6/PRIMA2/MARCO_DT...)?
> 

No, that's only necessary as long as we need legacy irq domains. If we
can figure out how to get the irqchip driver to use the linear domain,
it is not needed any more. If we move only the pinctrl domain to
linear but leave the main irqchip as legacy, we should set .nr_irqs=128.

	Arnd
