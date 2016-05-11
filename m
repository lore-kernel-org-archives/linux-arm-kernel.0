From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 11 May 2016 15:28:42 +0100
Subject: [PATCH v3 24/55] KVM: arm/arm64: vgic-new: Add ENABLE registers
 handlers
In-Reply-To: <57333F18.5030605@arm.com>
References: <1462531568-9799-1-git-send-email-andre.przywara@arm.com>
 <1462531568-9799-25-git-send-email-andre.przywara@arm.com>
 <20160511123423.GO27623@cbox> <5733300C.9070304@arm.com>
 <57333F18.5030605@arm.com>
Message-ID: <5733419A.9060001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/16 15:18, Andre Przywara wrote:
> Would:
> 
> #define VGIC_ADDR_IRQ_MASK(bits) GENMASK_ULL((bits) + 10 - 1 - 1, 0)

Nonsense. Must be ... ilog2(bits) ..., of course.

Andre.

> #define VGIC_ADDR_TO_INTID(addr, bits) (((addr) &		\
> 			VGIC_ADDR_IRQ_MASK(bits)) * 64 / (bits) / 8)
> 
> work for all bitnesses?
