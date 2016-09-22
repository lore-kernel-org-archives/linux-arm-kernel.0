From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Sep 2016 11:01:10 +0100
Subject: [PATCH v4 01/10] arm64: KVM: Use static keys for selecting the
 GIC backend
In-Reply-To: <1473691764-29424-2-git-send-email-vladimir.murzin@arm.com>
References: <1473691764-29424-1-git-send-email-vladimir.murzin@arm.com>
 <1473691764-29424-2-git-send-email-vladimir.murzin@arm.com>
Message-ID: <57E3ABE6.6000703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/16 15:49, Vladimir Murzin wrote:
> Currently GIC backend is selected via alternative framework and this
> is fine. We are going to introduce vgic-v3 to 32-bit world and there
> we don't have patching framework in hand, so we can either check
> support for GICv3 every time we need to choose which backend to use or
> try to optimise it by using static keys. The later looks quite
> promising because we can share logic involved in selecting GIC backend
> between architectures if both uses static keys.
> 
> This patch moves arm64 from alternative to static keys framework for
> selecting GIC backend. For that we embed static key into vgic_global
> and enable the key during vgic initialisation based on what has
> already been exposed by the host GIC driver.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm64/kvm/hyp/switch.c   |   21 +++++++++++----------
>  include/kvm/arm_vgic.h        |    4 ++++
>  virt/kvm/arm/vgic/vgic-init.c |    4 ++++
>  virt/kvm/arm/vgic/vgic.c      |    2 +-
>  4 files changed, 20 insertions(+), 11 deletions(-)

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
