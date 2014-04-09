From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 9 Apr 2014 22:26:29 +0800
Subject: [PATCH] gpio: mxs: Allow for recursive enable_irq_wake() call
In-Reply-To: <CACRpkda1qnx24YdfnSwu3tJw9NiVKpKjNbibGoG5JeZ+rAFpeQ@mail.gmail.com>
References: <1395628690-7225-1-git-send-email-marex@denx.de>
 <CACRpkda1qnx24YdfnSwu3tJw9NiVKpKjNbibGoG5JeZ+rAFpeQ@mail.gmail.com>
Message-ID: <20140409142626.GA2317@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 27, 2014 at 10:15:27AM +0100, Linus Walleij wrote:
> I would like someone to look into converting the MXS to use the new
> gpiolib irqchip helpers merged on my devel branch so we can centralize
> and get rid of surplus redundant bug fixing everywhere around the drivers.
> 
> That code does not use generic irqchip, but rather a regular irqchip+domain
> and explicitly chained interrupt handlers.

No.  The driver uses generic irqchip.  See function mxs_gpio_init_gc().

Shawn
