From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 21 Nov 2014 02:32:44 +0100 (CET)
Subject: [PATCH] irqdomain: Fix NULL pointer dererence in
 irq_domain_free_irqs_parent
In-Reply-To: <1416531745-24661-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1416531745-24661-1-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <alpine.DEB.2.11.1411210219370.6439@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Nov 2014, suravee.suthikulpanit at amd.com wrote:
> This patch checks if the parent domain is NULL before recursively freeing
> irqs in the parent domains.

Which is nonsense, because if the thing has not been allocated in the
first place, then it cannot explode in the free path magically, except
there is a missing check in the allocation path error handling.
 
And that's obviously not the case simply because this originates from:
> [<fffffe0000449278>] pci_disable_msix+0x40/0x50
 
Suravee, this is the last warning. I'm tired of your half baken
patches which lack any explanation. Read back on my previous replies
to your mails for further explanation.

This is not a 'try and error and hack enough nonsensical checks into
the code' commercial project.

This is core kernel code and requires proper explanation.

Thanks,

	tglx
