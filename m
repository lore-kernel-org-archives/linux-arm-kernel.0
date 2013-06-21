From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Fri, 21 Jun 2013 13:50:20 -0700
Subject: [PATCH] ARM: kvm: don't include drivers/virtio/Kconfig
In-Reply-To: <201306212233.23062.arnd@arndb.de>
References: <201306212233.23062.arnd@arndb.de>
Message-ID: <20130621205020.GA6815@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 10:33:22PM +0200, Arnd Bergmann wrote:
> The virtio configuration has recently moved and is now visible everywhere.
> Including the file again from KVM as we used to need earlier now causes
> dependency problems:
> 
> warning: (CAIF_VIRTIO && VIRTIO_PCI && VIRTIO_MMIO && REMOTEPROC && RPMSG)
> selects VIRTIO which has unmet direct dependencies (VIRTUALIZATION)
> 
> Cc: Christoffer Dall <cdall@cs.columbia.edu>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
> index 370e1a8..017db7c 100644
> --- a/arch/arm/kvm/Kconfig
> +++ b/arch/arm/kvm/Kconfig
> @@ -67,6 +67,4 @@ config KVM_ARM_TIMER
>  	---help---
>  	  Adds support for the Architected Timers in virtual machines
>  
> -source drivers/virtio/Kconfig
> -
>  endif # VIRTUALIZATION

Thanks, queued for 3.11.

-Christoffer
