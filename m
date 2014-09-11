From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 11 Sep 2014 05:09:32 +0200
Subject: [PATCH] KVM: EVENTFD: remove inclusion of irq.h
In-Reply-To: <54044647.4030605@redhat.com>
References: <1409560568-6911-1-git-send-email-eric.auger@linaro.org>
 <54044647.4030605@redhat.com>
Message-ID: <20140911030932.GA2784@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 01, 2014 at 12:11:19PM +0200, Paolo Bonzini wrote:
> Il 01/09/2014 10:36, Eric Auger ha scritto:
> > No more needed. irq.h would be void on ARM.
> > 
> > Signed-off-by: Eric Auger <eric.auger@linaro.org>
> > 
> > ---
> > 
> > I don't think irq.h is needed anymore since Paul Mackerras' work. However
> > I did not compile for all architectures.
> > ---
> >  virt/kvm/eventfd.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> > index 3c5981c..0c712a7 100644
> > --- a/virt/kvm/eventfd.c
> > +++ b/virt/kvm/eventfd.c
> > @@ -36,7 +36,6 @@
> >  #include <linux/seqlock.h>
> >  #include <trace/events/kvm.h>
> >  
> > -#include "irq.h"
> >  #include "iodev.h"
> >  
> >  #ifdef CONFIG_HAVE_KVM_IRQFD
> > 
> 
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Christoffer, please include this via the ARM tree, together with ARM
> irqfd support.  Thanks,
> 
Marc is dealing with the tree this week and the next so he can apply it
to kvmarm/queue.  Do you want it to wait and go with the irqfd patch
(which has dependencies not yet resolved) or should we just queue it?

Thanks,
-Christoffer
