From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 15 Jan 2014 19:06:15 +0100
Subject: device-tree: at91: irq and gpios: problem while requesting a
 gpio used as an interrupt source.
In-Reply-To: <52D3C166.5050908@overkiz.com>
References: <CACh+v5Os_FHh39oXGt=srw0s7bVkpnpH0pQ4ugit_k5BL_k-0A@mail.gmail.com>
 <52D3C166.5050908@overkiz.com>
Message-ID: <20140115180615.GJ9558@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:35 Mon 13 Jan     , boris brezillon wrote:
> On 13/01/2014 11:29, Jean-Jacques Hiblot wrote:
> >Hello Nicolas, Jean-Christophe,
> >
> >As I was trying to enable the touchscreen on the at91sam9261ek with
> >device-tree support, I ran into an issue. The touchscreen driver needs
> >to know the state of the pendown gpio and also needs it as an
> >interrupt source.
> >
> >The problem is that when a gpio is used as an interrupt, it's
> >requested by the pinctrl driver during the xlate stage, marking it
> >unavaliable for the other driver.
> >It looks like the at91 pinctrl driver is the only one to use
> >gpio_request() in the xlate stage. Maybe we should remove this:
> 
> You should only request it as a GPIO and then use gpio_to_irq to get the
> related IRQ.

This here a HUGE issue in the hole kernel

You should NEVER known ti's a gpio in the driver at all gpio_to_irq should never
exist you need to only see the irq

> Because what is done here, is to solve the case where only the irq
> is request, and in this specific case we need to request the pin as a
> GPIO.
this need to be handled at irq level not drivers

Best Regards,
J.
