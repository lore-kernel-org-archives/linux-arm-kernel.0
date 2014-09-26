From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Fri, 26 Sep 2014 23:08:29 +0900
Subject: [PATCH 1/2] arm64: KVM: Implement 48 VA support for KVM EL2 and
 Stage-2
In-Reply-To: <1411674174-30672-2-git-send-email-christoffer.dall@linaro.org>
References: <1411674174-30672-1-git-send-email-christoffer.dall@linaro.org>
 <1411674174-30672-2-git-send-email-christoffer.dall@linaro.org>
Message-ID: <83040F34-A8F4-4C4E-8FF8-F2846029A577@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sep 26, 2014, at 4:42 AM, Christoffer Dall wrote:

Hi, Christoffer

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

This is a very similar idea suggested by Steve Capper to deal with swapper
table when I worked on 4 level solution. I believe that dummy PGD approach
can handle all combinations described in ARMv8 architecture. 

> Systems with a PARange < 40bits are not yet supported.
> 
> [ I have reworked this patch from its original form submitted by
>   Jungseok to take the architecture constraints into consideration.
>   There were too many changes from the original patch for me to
>   preserve the authorship.  Thanks to Catalin Marinas for his help in
>   figuring out a good solution to this challenge.  I have also fixed
>   various bugs and missing error code handling from the original
>   patch. - Christoffer ]

No doubt. This is yours :)
I really thank you for picking up the patch and writing this graceful solution.

At first glance, it looks good except some unnecessary newlines.
I will leave comments after reading the patches carefully.

Best Regards
Jungseok Lee
