From: rmallon@gmail.com (Ryan Mallon)
Date: Wed, 02 Nov 2011 09:27:03 +1100
Subject: [PATCH 1/5] ARM: restart: remove argument to setup_mm_for_reboot()
In-Reply-To: <E1RLGt2-0005IN-A0@rmk-PC.arm.linux.org.uk>
References: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
	<E1RLGt2-0005IN-A0@rmk-PC.arm.linux.org.uk>
Message-ID: <4EB07237.1090001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/11 03:08, Russell King - ARM Linux wrote:

> setup_mm_for_reboot() doesn't make use of its argument, so remove it.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/kernel/machine_kexec.c |    4 ++--
>  arch/arm/kernel/process.c       |    4 ++--
>  arch/arm/mm/idmap.c             |    2 +-
>  arch/arm/mm/nommu.c             |    2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index c1b4463..6fcdfc4 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -16,7 +16,7 @@
>  extern const unsigned char relocate_new_kernel[];
>  extern const unsigned int relocate_new_kernel_size;
>  
> -extern void setup_mm_for_reboot(char mode);
> +extern void setup_mm_for_reboot(void);
>  
>  extern unsigned long kexec_start_address;
>  extern unsigned long kexec_indirection_page;
> @@ -114,7 +114,7 @@ void machine_kexec(struct kimage *image)
>  		kexec_reinit();
>  	local_irq_disable();
>  	local_fiq_disable();
> -	setup_mm_for_reboot(0); /* mode is not used, so just pass 0*/
> +	setup_mm_for_reboot(); /* mode is not used, so just pass 0*/


The comment should get removed now also.

~Ryan
