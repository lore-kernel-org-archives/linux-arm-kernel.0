From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 21 Aug 2014 14:28:48 +0200
Subject: [PATCH 9/9] ARM: zynq: Rename 'zynq_platform_cpu_die'
In-Reply-To: <1408567315-28479-10-git-send-email-soren.brinkmann@xilinx.com>
References: <1408567315-28479-1-git-send-email-soren.brinkmann@xilinx.com>
 <1408567315-28479-10-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <4ac42f4d-72bf-4a8d-a997-094f129d7c74@BN1AFFO11FD020.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2014 10:41 PM, Soren Brinkmann wrote:
> Match the naming pattern of all other SMP ops and rename
> zynq_platform_cpu_die --> zynq_cpu_die.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  arch/arm/mach-zynq/platsmp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
> index 04e578718aa2..95933c5e70e1 100644
> --- a/arch/arm/mach-zynq/platsmp.c
> +++ b/arch/arm/mach-zynq/platsmp.c
> @@ -138,7 +138,7 @@ static int zynq_cpu_kill(unsigned cpu)
>   *
>   * Called with IRQs disabled
>   */
> -static void zynq_platform_cpu_die(unsigned int cpu)
> +static void zynq_cpu_die(unsigned int cpu)
>  {
>  	zynq_slcr_cpu_state_write(cpu, true);
>  
> @@ -158,7 +158,7 @@ struct smp_operations zynq_smp_ops __initdata = {
>  	.smp_boot_secondary	= zynq_boot_secondary,
>  	.smp_secondary_init	= zynq_secondary_init,
>  #ifdef CONFIG_HOTPLUG_CPU
> -	.cpu_die		= zynq_platform_cpu_die,
> +	.cpu_die		= zynq_cpu_die,
>  	.cpu_kill		= zynq_cpu_kill,
>  #endif
>  };

Will be good if you can move fix that kernel-doc format for this function
too. It is just nice to have thing.

Thanks,
Michal



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140821/5a97616f/attachment.sig>
