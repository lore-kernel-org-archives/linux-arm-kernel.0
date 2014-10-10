From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 10 Oct 2014 16:09:32 +0100
Subject: [PATCH v3 2/3] arm/arm64: KVM: Ensure memslots are within
 KVM_PHYS_SIZE
In-Reply-To: <1412936070-18860-3-git-send-email-christoffer.dall@linaro.org>
References: <1412936070-18860-1-git-send-email-christoffer.dall@linaro.org>
 <1412936070-18860-3-git-send-email-christoffer.dall@linaro.org>
Message-ID: <20141010150932.GB7758@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 10, 2014 at 11:14:29AM +0100, Christoffer Dall wrote:
> When creating or moving a memslot, make sure the IPA space is within the
> addressable range of the guest.  Otherwise, user space can create too
> large a memslot and KVM would try to access potentially unallocated page
> table entries when inserting entries in the Stage-2 page tables.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
