From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 9 Dec 2016 14:41:36 +0000
Subject: [PATCH v8 03/16] irq: move IRQ routing into irq.c
In-Reply-To: <20161104173203.21168-4-andre.przywara@arm.com>
References: <20161104173203.21168-1-andre.przywara@arm.com>
 <20161104173203.21168-4-andre.przywara@arm.com>
Message-ID: <0e620cdd-3a3e-33d4-d1fa-80866a67cd72@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/16 17:31, Andre Przywara wrote:
> The current IRQ routing code in x86/irq.c is mostly implementing a
> generic KVM interface which other architectures may use too.
> Move the code to set up an MSI route into the generic irq.c file and
> guard it with the KVM_CAP_IRQ_ROUTING capability to return an error
> if the kernel does not support interrupt routing.
> This also removes the dummy implementations for all other
> architectures and only leaves the x86 specific code in x86/irq.c.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
