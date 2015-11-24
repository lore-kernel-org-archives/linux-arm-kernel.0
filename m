From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 24 Nov 2015 18:20:37 +0100
Subject: [PATCH] arm64: kvm: report original PAR_EL1 upon panic
In-Reply-To: <1447682309-5875-1-git-send-email-mark.rutland@arm.com>
References: <1447682309-5875-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20151124172037.GC18855@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 01:58:29PM +0000, Mark Rutland wrote:
> If we call __kvm_hyp_panic while a guest context is active, we call
> __restore_sysregs before acquiring the system register values for the
> panic, in the process throwing away the PAR_EL1 value at the point of
> the panic.
> 
> This patch modifies __kvm_hyp_panic to stash the PAR_EL1 value prior to
> restoring host register values, enabling us to report the original
> values at the point of the panic.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>

Thanks, applied.

-Christoffer
