From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 13 Jan 2014 18:38:00 +0400
Subject: [PATCH v2 1/3] ARM: clps711x: Add CLPS711X irqchip driver
In-Reply-To: <5805022.go1dlAzuQx@wuerfel>
References: <1387454336-1347-1-git-send-email-shc_work@mail.ru>
 <3585542.v49U0LMMmk@wuerfel>
 <20140109162035.a23fac6b35297b63d67163e0@mail.ru>
 <5805022.go1dlAzuQx@wuerfel>
Message-ID: <20140113183800.6f63b40328a659cabfd566f1@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On Thu, 09 Jan 2014 13:26:41 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Thursday 09 January 2014 16:20:35 Alexander Shiyan wrote:
> > So, irq_domain_add_simple() do not work for me.
> > Current driver uses 1:1 mapping between hwirq and virq. Since DT is not
> > supported by all CLPS711X drivers, I am initialize some devices in
> > init_machine call, so these devices uses 0-based IRQs (i.e. old scheme).
> > Using irq_domain_add_simple() means all our IRQs will be dynamic and its
> > numbers starts from NR_IRQS, so usage irq_domain_add_simple() at this stage
> > is not possible. Once all boards will be ported to DT, I'll review this
> > code, but cannot do it now.
> 
> Ok, makes sense. I didn't know you were mixing static devices
> with DT-probed ones. Your driver looks good then.

So, I still hope for the chance to put this into 3.14-rc.
Thanks.

-- 
Alexander Shiyan <shc_work@mail.ru>
