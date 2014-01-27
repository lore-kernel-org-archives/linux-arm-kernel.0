From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 27 Jan 2014 03:30:41 -0300
Subject: [PATCH v3 04/15] watchdog: orion: Handle IRQ
In-Reply-To: <52DE84A6.6090909@roeck-us.net>
References: <1390310774-20781-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390310774-20781-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <52DE84A6.6090909@roeck-us.net>
Message-ID: <20140127063040.GA17506@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

On Tue, Jan 21, 2014 at 06:31:02AM -0800, Guenter Roeck wrote:
[..]
> > @@ -131,6 +138,19 @@ static int orion_wdt_probe(struct platform_device *pdev)
> >   	if (!wdt_reg)
> >   		return -ENOMEM;
> >
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq > 0) {
> 
> 0 is a valid interrupt number, and platform_get_irq returns an error code on errors.
> Should be >= 0.
> 

I'm revisiting this one. I believe this is not the hardware interrupt
number, but the one mapped into virq space. So, 0 is not a valid
interrupt number.

Right?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
