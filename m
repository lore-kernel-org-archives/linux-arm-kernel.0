From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 20 May 2013 16:57:40 +0100
Subject: [PATCH v4 07/32] arm64: KVM: architecture specific MMU backend
In-Reply-To: <1368540840-26750-8-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
 <1368540840-26750-8-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130520155739.GF3639@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 03:13:35PM +0100, Marc Zyngier wrote:
> +static inline bool kvm_is_write_fault(unsigned long esr)
> +{
> +	unsigned long esr_ec = esr >> ESR_EL2_EC_SHIFT;

Not that it would make much difference but for consistency - we use esr
as an 'unsigned int' in the arm64 code (only 32-bit needed).

-- 
Catalin
