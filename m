From: cdall@linaro.org (Christoffer Dall)
Date: Wed, 29 Nov 2017 18:12:59 +0100
Subject: [PATCH] kvm: arm: don't treat unavailable HYP mode as an error
In-Reply-To: <20171128151819.18669-1-ard.biesheuvel@linaro.org>
References: <20171128151819.18669-1-ard.biesheuvel@linaro.org>
Message-ID: <20171129171259.GC10563@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 03:18:19PM +0000, Ard Biesheuvel wrote:
> Since it is perfectly legal to run the kernel at EL1, it is not
> actually an error if HYP mode is not available when attempting to
> initialize KVM, given that KVM support cannot be built as a module.
> So demote the kvm_err() to kvm_info(), which prevents the error from
> appearing on an otherwise 'quiet' console.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  virt/kvm/arm/arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 772bf74ac2e9..988c888a9667 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -1460,7 +1460,7 @@ int kvm_arch_init(void *opaque)
>  	bool in_hyp_mode;
>  
>  	if (!is_hyp_mode_available()) {
> -		kvm_err("HYP mode not available\n");
> +		kvm_info("HYP mode not available\n");
>  		return -ENODEV;
>  	}
>  
> -- 
> 2.11.0
> 
Applied, thanks.
-Christoffer
