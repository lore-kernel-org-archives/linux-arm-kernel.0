From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 10 Oct 2014 16:09:10 +0100
Subject: [PATCH v3 1/3] arm64: KVM: Implement 48 VA support for KVM EL2
 and Stage-2
In-Reply-To: <1412936070-18860-2-git-send-email-christoffer.dall@linaro.org>
References: <1412936070-18860-1-git-send-email-christoffer.dall@linaro.org>
 <1412936070-18860-2-git-send-email-christoffer.dall@linaro.org>
Message-ID: <20141010150908.GA7758@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 10, 2014 at 11:14:28AM +0100, Christoffer Dall wrote:
> This patch adds the necessary support for all host kernel PGSIZE and
> VA_SPACE configuration options for both EL2 and the Stage-2 page tables.
> 
> However, for 40bit and 42bit PARange systems, the architecture mandates
> that VTCR_EL2.SL0 is maximum 1, resulting in fewer levels of stage-2
> pagge tables than levels of host kernel page tables.  At the same time,
> systems with a PARange > 42bit, we limit the IPA range by always setting
> VTCR_EL2.T0SZ to 24.
> 
> To solve the situation with different levels of page tables for Stage-2
> translation than the host kernel page tables, we allocate a dummy PGD
> with pointers to our actual inital level Stage-2 page table, in order
> for us to reuse the kernel pgtable manipulation primitives.  Reproducing
> all these in KVM does not look pretty and unnecessarily complicates the
> 32-bit side.
> 
> Systems with a PARange < 40bits are not yet supported.
> 
>  [ I have reworked this patch from its original form submitted by
>    Jungseok to take the architecture constraints into consideration.
>    There were too many changes from the original patch for me to
>    preserve the authorship.  Thanks to Catalin Marinas for his help in
>    figuring out a good solution to this challenge.  I have also fixed
>    various bugs and missing error code handling from the original
>    patch. - Christoffer ]
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
