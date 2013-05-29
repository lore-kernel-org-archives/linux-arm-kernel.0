From: monstr@monstr.eu (Michal Simek)
Date: Wed, 29 May 2013 07:39:18 +0200
Subject: [PATCH 5/8] ARM: zynq: use generic cpu idle function for wfi
In-Reply-To: <1369665166-13049-6-git-send-email-sanjay.rawat@linaro.org>
References: <1369665166-13049-1-git-send-email-sanjay.rawat@linaro.org>
 <1369665166-13049-6-git-send-email-sanjay.rawat@linaro.org>
Message-ID: <51A59486.4040901@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/27/2013 04:32 PM, Sanjay Singh Rawat wrote:
> use cpu_do_idle for entering the wfi mode.
> 
> Signed-off-by: Sanjay Singh Rawat <sanjay.rawat@linaro.org>
> ---
>  arch/arm/mach-zynq/hotplug.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-zynq/hotplug.c b/arch/arm/mach-zynq/hotplug.c
> index c89672b..ef0d65d 100644
> --- a/arch/arm/mach-zynq/hotplug.c
> +++ b/arch/arm/mach-zynq/hotplug.c
> @@ -64,8 +64,8 @@ static inline void zynq_platform_do_lowpower(unsigned int cpu, int *spurious)
>  	 * code will have already disabled interrupts
>  	 */
>  	for (;;) {
> -		dsb();
> -		wfi();
> +		/* enter WFI mode */
> +		cpu_do_idle();
>  
>  		/*
>  		 * Getting here, means that we have come out of WFI without
> 

Applied to zynq/cleanup branch.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130529/663c5f5e/attachment.sig>
