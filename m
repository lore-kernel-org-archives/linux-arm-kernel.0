From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 23 Mar 2017 17:58:05 +0000
Subject: [PATCH V13 10/10] arm/arm64: KVM: add guest SEA support
In-Reply-To: <1490136425-4324-11-git-send-email-tbaicar@codeaurora.org>
References: <1490136425-4324-1-git-send-email-tbaicar@codeaurora.org>
 <1490136425-4324-11-git-send-email-tbaicar@codeaurora.org>
Message-ID: <20170323175805.GC32309@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 04:47:05PM -0600, Tyler Baicar wrote:
> Currently external aborts are unsupported by the guest abort
> handling. Add handling for SEAs so that the host kernel reports
> SEAs which occur in the guest kernel.
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  arch/arm/include/asm/kvm_arm.h       | 10 +++++++++
>  arch/arm/include/asm/system_misc.h   |  5 +++++
>  arch/arm/kvm/mmu.c                   | 41 ++++++++++++++++++++++++++++++------
>  arch/arm64/include/asm/kvm_arm.h     | 10 +++++++++
>  arch/arm64/include/asm/system_misc.h |  2 ++
>  arch/arm64/mm/fault.c                | 19 +++++++++++++++--
>  drivers/acpi/apei/ghes.c             | 13 ++++++------
>  include/acpi/ghes.h                  |  2 +-
>  8 files changed, 86 insertions(+), 16 deletions(-)

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Marc, Christoffer, could you please check the kvm bits in here? Thanks.

-- 
Catalin
