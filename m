From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 9 May 2018 09:56:52 +0100
Subject: [PATCH v6 12/15] KVM: arm64: Remove eager host SVE state saving
In-Reply-To: <1525797900-5548-13-git-send-email-Dave.Martin@arm.com>
References: <1525797900-5548-1-git-send-email-Dave.Martin@arm.com>
 <1525797900-5548-13-git-send-email-Dave.Martin@arm.com>
Message-ID: <34f4b9d4-9699-eb42-d451-39077e8f8dcd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/18 17:44, Dave Martin wrote:
> Now that the host SVE context can be saved on demand from Hyp,
> there is no longer any need to save this state in advance before
> entering the guest.
> 
> This patch removes the relevant call to
> kvm_fpsimd_flush_cpu_state().
> 
> Since the problem that function was intended to solve now no longer
> exists, the function and its dependencies are also deleted.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Acked-by: Christoffer Dall <christoffer.dall@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
