From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Feb 2016 21:16:30 +0100
Subject: [PATCH 1/4] gpio: remove broken irq_to_gpio() interface
In-Reply-To: <56C1F645.1070405@metafoo.de>
References: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <1455551208-2825510-2-git-send-email-arnd@arndb.de>
 <56C1F645.1070405@metafoo.de>
Message-ID: <4277616.myYDBWrFcU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 February 2016 17:01:09 Lars-Peter Clausen wrote:
> On 02/15/2016 04:46 PM, Arnd Bergmann wrote:
> > +static inline __deprecated int irq_to_gpio(unsigned int irq)
> > +{
> > +     /* this has clearly not worked for a long time */
> > +     return -EINVAL;
> > +}
> > +
> >  #define IRQ_TO_BIT(irq) BIT(irq_to_gpio(irq) & 0x1f)
> 
> The issue seems to be a fallout from commit 832f5dacfa0b ("MIPS: Remove all
> the uses of custom gpio.h").
> 
> The irq_to_gpio() should be replaced with "(irq - JZ4740_IRQ_GPIO(0))".
> 
> 

Ah, that explain it, so it has not been broken for that long.

	Arnd
