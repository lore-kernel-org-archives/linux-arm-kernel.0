From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 18 Feb 2014 11:30:56 -0800
Subject: [PATCH v4 12/12] ARM: KVM: fix warning in mmu.c
In-Reply-To: <1392737253-10480-13-git-send-email-marc.zyngier@arm.com>
References: <1392737253-10480-1-git-send-email-marc.zyngier@arm.com>
 <1392737253-10480-13-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140218193056.GB2084@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 03:27:33PM +0000, Marc Zyngier wrote:
> Compiling with THP enabled leads to the following warning:
> 
> arch/arm/kvm/mmu.c: In function ?unmap_range?:
> arch/arm/kvm/mmu.c:177:39: warning: ?pte? may be used uninitialized in this function [-Wmaybe-uninitialized]
>    if (kvm_pmd_huge(*pmd) || page_empty(pte)) {
>                                         ^
> Code inspection reveals that these two cases are mutually exclusive,
> so GCC is a bit overzealous here. Silence it anyway by initializing
> pte to NULL and testing it later on.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
