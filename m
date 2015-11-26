From: david.vrabel@citrix.com (David Vrabel)
Date: Thu, 26 Nov 2015 18:22:27 +0000
Subject: [Xen-devel] [PATCH] xen/events: Always allocate legacy interrupts
 on PV guests
In-Reply-To: <1448036704-18630-1-git-send-email-boris.ostrovsky@oracle.com>
References: <1448036704-18630-1-git-send-email-boris.ostrovsky@oracle.com>
Message-ID: <56574DE3.2040808@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/11/15 16:25, Boris Ostrovsky wrote:
> After commit 8c058b0b9c34 ("x86/irq: Probe for PIC presence before
> allocating descs for legacy IRQs") early_irq_init() will no longer
> preallocate descriptors for legacy interrupts if PIC does not
> exist, which is the case for Xen PV guests.
> 
> Therefore we may need to allocate those descriptors ourselves.

Applied to for-linus-4.4, thanks.

> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -7,4 +7,10 @@ struct pt_regs;
>  
>  extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
>  
> +#define NR_IRQS_LEGACY  0

I dropped this unnecessary #define.

David
