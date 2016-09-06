From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 6 Sep 2016 08:39:20 +0200
Subject: [RFC v2 PATCH 5/7] arm64/kvm: hyp: tlb: use __tlbi() helper
In-Reply-To: <1473093097-30932-6-git-send-email-punit.agrawal@arm.com>
References: <1473093097-30932-1-git-send-email-punit.agrawal@arm.com>
 <1473093097-30932-6-git-send-email-punit.agrawal@arm.com>
Message-ID: <20160906063920.GD30513@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 05:31:35PM +0100, Punit Agrawal wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> Now that we have a __tlbi() helper, make use of this in the arm64 KVM hyp
> code to get rid of asm() boilerplate. At the same time, we simplify
> __tlb_flush_vm_context by using __flush_icache_all(), as this has the
> appropriate instruction cache maintenance and barrier.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> [ rename tlbi -> __tlbi, convert additional sites, update commit log ]
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
