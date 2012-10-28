From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 28 Oct 2012 14:24:08 +0100
Subject: [PATCH v2 1/4] irqchip: add basic infrastructure
In-Reply-To: <508D30B2.6070806@gmail.com>
References: <1351416634-3352-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1351416634-3352-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <508D30B2.6070806@gmail.com>
Message-ID: <20121028142408.7512671c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Sun, 28 Oct 2012 08:18:42 -0500, Rob Herring wrote:

> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 1bb8bf6..e0ff166 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -1 +1,2 @@
> > -# empty
> > +config USE_IRQCHIP
> > +	bool
> 
> This should depend on OF_IRQ.

It is correct that the mechanism only works for irqchip drivers that
are probed through the Device Tree. However, having a "depends on"
inside a configuration that gets "select"ed by other configuration
options (in our case ARCH_BCM2835 and ARCH_MVEBU select USE_IRQCHIP) is
useless: kconfig doesn't care of the "depends on" dependencies when
you're "select"ing an option.

So, I can add it for documentation purposes, but it is practically
useless.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
