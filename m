From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 Mar 2015 17:01:52 +0000
Subject: [PATCH v2 04/12] KVM: x86: remove now unneeded include directory
 from Makefile
In-Reply-To: <1427126309-11223-5-git-send-email-andre.przywara@arm.com>
References: <1427126309-11223-1-git-send-email-andre.przywara@arm.com>
 <1427126309-11223-5-git-send-email-andre.przywara@arm.com>
Message-ID: <5512EA00.2070105@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/03/15 15:58, Andre Przywara wrote:
> virt/kvm was never really a good include directory for anything else
> than locally included headers.
> With the move of iodev.h there is no need anymore to add this
> directory the compiler's include path, so remove it from the x86 kvm
> Makefile.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Paolo, Marcelo: can we have your Ack on this?

Thanks,

	M.

> ---
>  arch/x86/kvm/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
> index 08f790d..16e8f96 100644
> --- a/arch/x86/kvm/Makefile
> +++ b/arch/x86/kvm/Makefile
> @@ -1,5 +1,5 @@
>  
> -ccflags-y += -Ivirt/kvm -Iarch/x86/kvm
> +ccflags-y += -Iarch/x86/kvm
>  
>  CFLAGS_x86.o := -I.
>  CFLAGS_svm.o := -I.
> 


-- 
Jazz is not dead. It just smells funny...
