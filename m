From: mingo@kernel.org (Ingo Molnar)
Date: Fri, 18 Nov 2016 09:25:22 +0100
Subject: [PATCHv3 1/6] lib/Kconfig.debug: Add ARCH_HAS_DEBUG_VIRTUAL
In-Reply-To: <1479431816-5028-2-git-send-email-labbott@redhat.com>
References: <1479431816-5028-1-git-send-email-labbott@redhat.com>
 <1479431816-5028-2-git-send-email-labbott@redhat.com>
Message-ID: <20161118082521.GA7250@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Laura Abbott <labbott@redhat.com> wrote:

> 
> DEBUG_VIRTUAL currently depends on DEBUG_KERNEL && X86. arm64 is getting
> the same support. Rather than add a list of architectures, switch this
> to ARCH_HAS_DEBUG_VIRTUAL and let architectures select it as
> appropriate.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v3: No change, x86 maintainers please ack if you are okay with this.
> ---
>  arch/x86/Kconfig  | 1 +
>  lib/Kconfig.debug | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index bada636..f533321 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -23,6 +23,7 @@ config X86
>  	select ARCH_CLOCKSOURCE_DATA
>  	select ARCH_DISCARD_MEMBLOCK
>  	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
> +	select ARCH_HAS_DEBUG_VIRTUAL
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
>  	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_FAST_MULTIPLIER

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
