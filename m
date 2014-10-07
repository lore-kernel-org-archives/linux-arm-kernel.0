From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 7 Oct 2014 12:31:42 +0200
Subject: [PATCH] ARM: KVM: fix vgic-disabled build
In-Reply-To: <3777204.xp7MBjnQbJ@wuerfel>
References: <3777204.xp7MBjnQbJ@wuerfel>
Message-ID: <20141007103142.GF3717@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 01:38:20PM +0200, Arnd Bergmann wrote:
> The vgic code can be disabled in Kconfig and there are dummy implementations
> of most of the provided API functions for the disabled case.
> 
> However, the newly introduced kvm_vgic_destroy/kvm_vgic_vcpu_destroy
> functions are lacking those dummies, resulting in this build error:
> 
> arch/arm/kvm/arm.c: In function 'kvm_arch_destroy_vm':
> arch/arm/kvm/arm.c:165:2: error: implicit declaration of function 'kvm_vgic_destroy' [-Werror=implicit-function-declaration]
>   kvm_vgic_destroy(kvm);
>   ^
> arch/arm/kvm/arm.c: In function 'kvm_arch_vcpu_free':
> arch/arm/kvm/arm.c:248:2: error: implicit declaration of function 'kvm_vgic_vcpu_destroy' [-Werror=implicit-function-declaration]
>   kvm_vgic_vcpu_destroy(vcpu);
>   ^
> 
> This adds two inline helpers to get it to build again in this configuration.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: c1bfb577add ("arm/arm64: KVM: vgic: switch to dynamic allocation")

Hi Arnd,

Thanks for the fix, it has been applied.

-Christoffer
