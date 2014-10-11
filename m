From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 11 Oct 2014 10:01:12 +0100
Subject: [PATCH v3 2/3] arm/arm64: KVM: Ensure memslots are within
 =?UTF-8?Q?KVM=5FPHYS=5FSIZE?=
In-Reply-To: <1412936070-18860-3-git-send-email-christoffer.dall@linaro.org>
References: <1412936070-18860-1-git-send-email-christoffer.dall@linaro.org>
 <1412936070-18860-3-git-send-email-christoffer.dall@linaro.org>
Message-ID: <4e418b1f6726f585bb31c209c9f84336@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-10-10 11:14, Christoffer Dall wrote:
> When creating or moving a memslot, make sure the IPA space is within 
> the
> addressable range of the guest.  Otherwise, user space can create too
> large a memslot and KVM would try to access potentially unallocated 
> page
> table entries when inserting entries in the Stage-2 page tables.
>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

         M.
-- 
Fast, cheap, reliable. Pick two.
