From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 13 Sep 2016 10:52:13 +0200
Subject: [PATCH v4 10/10] ARM: KVM: Support vgic-v3
In-Reply-To: <1473691764-29424-11-git-send-email-vladimir.murzin@arm.com>
References: <1473691764-29424-1-git-send-email-vladimir.murzin@arm.com>
 <1473691764-29424-11-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20160913085213.GJ5680@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 03:49:24PM +0100, Vladimir Murzin wrote:
> This patch allows to build and use vgic-v3 in 32-bit mode.
> 
> Unfortunately, it can not be split in several steps without extra
> stubs to keep patches independent and bisectable.  For instance,
> virt/kvm/arm/vgic/vgic-v3.c uses function from vgic-v3-sr.c, handling
> access to GICv3 cpu interface from the guest requires vgic_v3.vgic_sre
> to be already defined.
> 
> It is how support has been done:
> 
> * handle SGI requests from the guest
> 
> * report configured SRE on access to GICv3 cpu interface from the guest
> 
> * required vgic-v3 macros are provided via uapi.h
> 
> * static keys are used to select GIC backend
> 
> * to make vgic-v3 build KVM_ARM_VGIC_V3 guard is removed along with
>   the static inlines
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
