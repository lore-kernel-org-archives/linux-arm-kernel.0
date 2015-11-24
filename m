From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 24 Nov 2015 18:18:32 +0100
Subject: [PATCH] arm64: kvm: avoid %p in __kvm_hyp_panic
In-Reply-To: <1447682151-5827-1-git-send-email-mark.rutland@arm.com>
References: <1447682151-5827-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20151124171832.GB18855@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 01:55:51PM +0000, Mark Rutland wrote:
> Currently __kvm_hyp_panic uses %p for values which are not pointers,
> such as the ESR value. This can confusingly lead to "(null)" being
> printed for the value.
> 
> Use %x instead, and only use %p for host pointers.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>

Thanks, applied.

-Christoffer
