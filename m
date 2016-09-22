From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Sep 2016 10:57:34 +0100
Subject: [PATCH v4 09/10] ARM: gic-v3: Introduce 32-to-64-bit mappings for
 GICv3 cpu registers
In-Reply-To: <1473691764-29424-10-git-send-email-vladimir.murzin@arm.com>
References: <1473691764-29424-1-git-send-email-vladimir.murzin@arm.com>
 <1473691764-29424-10-git-send-email-vladimir.murzin@arm.com>
Message-ID: <57E3AB0E.5070308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/16 15:49, Vladimir Murzin wrote:
> vgic-v3 save/restore routines are written in such way that they map
> arm64 system register naming nicely, but it does not fit to arm
> world. To keep virt/kvm/arm/hyp/vgic-v3-sr.c untouched we create a
> mapping with a function for each register mapping the 32-bit to the
> 64-bit accessors.
> 
> Please, note that 64-bit wide ICH_LR is split in two 32-bit halves
> (ICH_LR and ICH_LRC) accessed independently.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm/include/asm/arch_gicv3.h |   64 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
