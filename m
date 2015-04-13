From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 13 Apr 2015 11:57:34 +0200
Subject: [PATCH v2] KVM: arm/arm64: avoid using kvm_run for in-kernel
 emulation
In-Reply-To: <1428677987-15494-1-git-send-email-andre.przywara@arm.com>
References: <1428677987-15494-1-git-send-email-andre.przywara@arm.com>
Message-ID: <20150413095734.GH6186@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 03:59:47PM +0100, Andre Przywara wrote:
> Our in-kernel VGIC emulation still uses struct kvm_run briefly before
> writing back the emulation result into the guest register.
> Although this particular case looks safe from an exploitation
> perspective, we can save some unneeded copying at the end of the VGIC
> emulation code.
> Replace the usage of struct kvm_run in favour of passing separate
> parameters in io_mem_abort(). Since the write back is now handled
> for all kvm_io_bus users, we can get rid of it in the VGIC.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
