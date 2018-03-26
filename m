From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 26 Mar 2018 16:11:22 +0100
Subject: [PATCH v2 04/11] KVM: arm/arm64: Add kvm_ras.h to collect kvm
 specific RAS plumbing
In-Reply-To: <20180322181445.23298-5-james.morse@arm.com>
References: <20180322181445.23298-1-james.morse@arm.com>
 <20180322181445.23298-5-james.morse@arm.com>
Message-ID: <790d3e45-26c2-6095-7adf-1d59fda4541e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/03/18 18:14, James Morse wrote:
> To split up APEIs in_nmi() path, we need any nmi-like callers to always
> be in_nmi(). KVM shouldn't have to know about this, pull the RAS plumbing
> out into a header file.
> 
> Currently guest synchronous external aborts are claimed as RAS
> notifications by handle_guest_sea(), which is hidden in the arch codes
> mm/fault.c. 32bit gets a dummy declaration in system_misc.h.
> 
> There is going to be more of this in the future if/when we support
> the SError-based firmware-first notification mechanism and/or
> kernel-first notifications for both synchronous external abort and
> SError. Each of these will come with some Kconfig symbols and a
> handful of header files.
> 
> Create a header file for all this.
> 
> This patch gives handle_guest_sea() a 'kvm_' prefix, and moves the
> declarations to kvm_ras.h as preparation for a future patch that moves
> the ACPI-specific RAS code out of mm/fault.c.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
