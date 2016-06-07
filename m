From: panand@redhat.com (Pratyush Anand)
Date: Tue, 7 Jun 2016 11:11:35 +0530
Subject: [PATCH kexec-tools v2 16/32] arm: fix ELF32/ELF64 check
In-Reply-To: <E1b9xsj-0003sy-Nx@e0050434b2927.dyn.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
 <E1b9xsj-0003sy-Nx@e0050434b2927.dyn.armlinux.org.uk>
Message-ID: <20160607054134.GB13643@dhcppc6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2016:06:00:05 PM, Russell King wrote:
> Rather than using ULONG_MAX to decide whether to use the ELF64 or ELF32
> core dump format, use UINT32_MAX instead - we include stdint.h, so we
> might as well use a constant which is meaningful for the limits of
> the 32-bit ELF format.
> 
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>
> ---
>  kexec/arch/arm/crashdump-arm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
> index a390187..fcc4d42 100644
> --- a/kexec/arch/arm/crashdump-arm.c
> +++ b/kexec/arch/arm/crashdump-arm.c
> @@ -369,8 +369,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
>  	if (last_ranges < 0)
>  		last_ranges = 0;
>  
> -	if (crash_memory_ranges[last_ranges].end > ULONG_MAX) {
> -
> +	if (crash_memory_ranges[last_ranges].end > UINT32_MAX) {
>  		/* for support LPAE enabled kernel*/
>  		elf_info.class = ELFCLASS64;
>  
> -- 
> 1.9.1
