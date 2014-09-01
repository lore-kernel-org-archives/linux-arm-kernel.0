From: pbonzini@redhat.com (Paolo Bonzini)
Date: Mon, 01 Sep 2014 12:11:19 +0200
Subject: [PATCH] KVM: EVENTFD: remove inclusion of irq.h
In-Reply-To: <1409560568-6911-1-git-send-email-eric.auger@linaro.org>
References: <1409560568-6911-1-git-send-email-eric.auger@linaro.org>
Message-ID: <54044647.4030605@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 01/09/2014 10:36, Eric Auger ha scritto:
> No more needed. irq.h would be void on ARM.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 
> ---
> 
> I don't think irq.h is needed anymore since Paul Mackerras' work. However
> I did not compile for all architectures.
> ---
>  virt/kvm/eventfd.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index 3c5981c..0c712a7 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -36,7 +36,6 @@
>  #include <linux/seqlock.h>
>  #include <trace/events/kvm.h>
>  
> -#include "irq.h"
>  #include "iodev.h"
>  
>  #ifdef CONFIG_HAVE_KVM_IRQFD
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Christoffer, please include this via the ARM tree, together with ARM
irqfd support.  Thanks,

Paolo
