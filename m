From: christoffer.dall@arm.com (Christoffer Dall)
Date: Tue, 15 May 2018 12:57:25 +0200
Subject: [PATCH v7 16/16] KVM: arm64: Invoke FPSIMD context switch trap
 from C
In-Reply-To: <1525882385-29181-17-git-send-email-Dave.Martin@arm.com>
References: <1525882385-29181-1-git-send-email-Dave.Martin@arm.com>
 <1525882385-29181-17-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180515105725.GE38551@C02W217FHV2R.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2018 at 05:13:05PM +0100, Dave Martin wrote:
> The conversion of the FPSIMD context switch trap code to C has added
> some overhead to calling it, due to the need to save registers that
> the procedure call standard defines as caller-saved.
> 
> So, perhaps it is no longer worth invoking this trap handler quite
> so early.
> 
> Instead, we can invoke it from fixup_guest_exit(), with little
> likelihood of increasing the overhead much further.
> 
> As a convenience, this patch gives __hyp_switch_fpsimd() the same
> return semantics fixup_guest_exit().  For now there is no
> possibility of a spurious FPSIMD trap, so the function always
> returns true, but this allows it to be tail-called with a single
> return statement.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
