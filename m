From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 12 Oct 2017 18:13:37 +0100
Subject: [PATCH v3 24/28] arm64/sve: KVM: Hide SVE from CPU features
 exposed to guests
In-Reply-To: <1507660725-7986-25-git-send-email-Dave.Martin@arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-25-git-send-email-Dave.Martin@arm.com>
Message-ID: <20171012171336.woymi76ve27wnbfi@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 07:38:41PM +0100, Dave P Martin wrote:
> KVM guests cannot currently use SVE, because SVE is always
> configured to trap to EL2.
> 
> However, a guest that sees SVE reported as present in
> ID_AA64PFR0_EL1 may legitimately expect that SVE works and try to
> use it.  Instead of working, the guest will receive an injected
> undef exception, which may cause the guest to oops or go into a
> spin.
> 
> To avoid misleading the guest into believing that SVE will work,
> this patch masks out the SVE field from ID_AA64PFR0_EL1 when a
> guest attempts to read this register.  No support is explicitly
> added for ID_AA64ZFR0_EL1 either, so that is still emulated as
> reading as zero, which is consistent with SVE not being
> implemented.
> 
> This is a temporary measure, and will be removed in a later series
> when full KVM support for SVE is implemented.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
