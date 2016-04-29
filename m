From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 29 Apr 2016 13:31:31 +0200
Subject: [PATCH] arm/arm64: KVM: Enforce Break-Before-Make on Stage-2
 page tables
In-Reply-To: <1461856591-5751-1-git-send-email-marc.zyngier@arm.com>
References: <1461856591-5751-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160429113131.GA24942@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2016 at 04:16:31PM +0100, Marc Zyngier wrote:
> The ARM architecture mandates that when changing a page table entry
> from a valid entry to another valid entry, an invalid entry is first
> written, TLB invalidated, and only then the new entry being written.
> 
> The current code doesn't respect this, directly writing the new
> entry and only then invalidating TLBs. Let's fix it up.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks for fixing this, I've applied it to next.

-Christoffer
