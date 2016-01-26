From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Jan 2016 17:07:39 +0100
Subject: [PATCH 3/4] irqchip: irq-armada-370-xp: use shorter names for
 irq_chip
In-Reply-To: <871tadfly0.fsf@free-electrons.com>
References: <1450707546-15060-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1450707546-15060-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <871tadfly0.fsf@free-electrons.com>
Message-ID: <20160126170739.5e8321a0@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory,

Thanks for your feedback!

On Wed, 23 Dec 2015 12:23:19 +0100, Gregory CLEMENT wrote:

> >  static struct irq_chip armada_370_xp_irq_chip = {
> > -	.name		= "armada_370_xp_irq",
> > +	.name		= "MPIC",
> 
> MPIC is the name also used by the power PC interrupt controller, so it
> would be confusing to use exactly the same name.

Not really: on a given system, you won't have the PowerPC interrupt
controller and the Marvell interrupt controller. For example, for the
ARM GIC, /proc/interrupts only shows GIC-0, not "ARM GIC-0".

> What about calling it "MRVL MPIC" or "MVEBU MPIC"?
> the name remains short but it won't be confused with the power PC ones.

Those names are still too long for a nice /proc/interrupts output:

# cat /proc/interrupts 
           CPU0       CPU1       
 17:       2878       2726     GIC-0  29 Edge      twd
 18:          0          0  MRVL MPIC   5 Level     armada_370_xp_per_cpu_tick
 21:        142          0     GIC-0  34 Level     mv64xxx_i2c
 22:        235          0     GIC-0  44 Level     serial
 37:          0          0     GIC-0  50 Level     ehci_hcd:usb1
 41:          0          0     GIC-0  53 Level     f10a3800.rtc
 42:          0          0     GIC-0  58 Level     ahci-mvebu[f10a8000.sata]
 43:          0          0     GIC-0  60 Level     ahci-mvebu[f10e0000.sata]
 44:       1040          0     GIC-0  57 Level     mmc0
 45:          0          0     GIC-0  48 Level     xhci-hcd:usb2
 46:          0          0     GIC-0  49 Level     xhci-hcd:usb4
108:          2          0     GIC-0  54 Level     f1060800.xor
109:          2          0     GIC-0  97 Level     f1060900.xor
110:          2          0  MRVL MSI MPIC 524288 Edge      eth0

Of course that's really a minor detail, but I don't think it's worth
making those names longer than "MSI MPIC" and "MPIC".

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
