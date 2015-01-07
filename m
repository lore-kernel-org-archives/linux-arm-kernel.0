From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 7 Jan 2015 15:17:36 +0100
Subject: [PATCH] arm64: KVM: Fix HCR setting for 32bit guests
In-Reply-To: <1420627503-25183-1-git-send-email-marc.zyngier@arm.com>
References: <1420627503-25183-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150107141736.GH21092@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 10:45:03AM +0000, Marc Zyngier wrote:
> Commit b856a59141b1 (arm/arm64: KVM: Reset the HCR on each vcpu
> when resetting the vcpu) moved the init of the HCR register to
> happen later in the init of a vcpu, but left out the fixup
> done in kvm_reset_vcpu when preparing for a 32bit guest.
> 
> As a result, the 32bit guest is run as a 64bit guest, but the
> rest of the kernel still manages it as a 32bit. Fun follows.
> 
> Moving the fixup to vcpu_reset_hcr solves the problem for good.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Whoops, thanks for the fix.

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
