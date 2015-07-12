From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 12 Jul 2015 18:49:26 +0200 (CEST)
Subject: [PATCH v2 00/13] Kill off set_irq_flags
In-Reply-To: <1436711211-18223-1-git-send-email-robh@kernel.org>
References: <1436711211-18223-1-git-send-email-robh@kernel.org>
Message-ID: <alpine.DEB.2.11.1507121845000.20072@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 12 Jul 2015, Rob Herring wrote:
> This series converts all users of ARM specific set_irq_flags to use
> common genirq functions. set_irq_flags is just a wrapper around
> irq_modify_status, so this simply removes the wrapper to directly call
> irq_modify_status (or other helpers) and the translation from ARM
> specific flags to genirq flags. The final irq flag states are unchanged.
> In many cases where irqdomains are used, the set_irq_flags calls were
> redundant, so I've removed them.
> 
> The last version has been run thru kernelci.org testing (thanks Kevin H!).
> I plan to send this series through arm-soc. I still need acks from the To

Please send the patches through the subsystem maintainers. I have
other irq related changes pending for more or less the same files. So
having one part in arm-soc and the other in drivers/* is not a really
good idea conflict wise.

We can remove the implementations right after 4.3-rc1. If susbsystems
have not picked up their lot when the merge window opens (i.e. not in
-next), we can feed them through tip/irq as I plan with the stuff I'm
sending out next week.

Thanks,

	tglx
