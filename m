From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 23 Nov 2014 14:33:30 +0100
Subject: [PATCH v4 14/19] arm/arm64: KVM: add opaque private pointer to
 MMIO data
In-Reply-To: <1415959683-26027-15-git-send-email-andre.przywara@arm.com>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <1415959683-26027-15-git-send-email-andre.przywara@arm.com>
Message-ID: <20141123133330.GA3401@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 10:07:58AM +0000, Andre Przywara wrote:
> For a GICv2 there is always only one (v)CPU involved: the one that
> does the access. On a GICv3 the access to a CPU redistributor is
> memory-mapped, but not banked, so the (v)CPU affected is determined by
> looking at the MMIO address region being accessed.
> To allow passing the affected CPU into the accessors later, extend
> struct kvm_exit_mmio to add an opaque private pointer parameter.
> The current GICv2 emulation just does not use it.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---

Looks reasonable:

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
