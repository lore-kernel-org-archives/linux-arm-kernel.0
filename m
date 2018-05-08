From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 8 May 2018 11:51:17 +0100
Subject: [PATCH v5 12/14] KVM: arm64: Remove redundant *exit_code changes
 in fpsimd_guest_exit()
In-Reply-To: <1525449935-31424-13-git-send-email-Dave.Martin@arm.com>
References: <1525449935-31424-1-git-send-email-Dave.Martin@arm.com>
 <1525449935-31424-13-git-send-email-Dave.Martin@arm.com>
Message-ID: <a1f8ba62-1f39-5649-a92b-88aad0358d22@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/18 17:05, Dave Martin wrote:
> In fixup_guest_exit(), there are a couple of cases where after
> checking what the exit code was, we assign it explicitly with the
> value it already had.
> 
> Assuming this is not indicative of a bug, these assignments are not
> needed.
> 
> This patch removes the redundant assignments simplifies some if-
> nesting that becomes trivial as a result.
> 
> No functional change.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
