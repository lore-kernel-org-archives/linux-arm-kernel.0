From: dinguyen@kernel.org (Dinh Nguyen)
Date: Sun, 19 Feb 2017 14:15:01 -0600
Subject: [PATCH 3/3] ARM: socfpga: PM: Drop useless check for
 PM_SUSPEND_STANDBY
In-Reply-To: <1487347836-14427-4-git-send-email-geert+renesas@glider.be>
References: <1487347836-14427-1-git-send-email-geert+renesas@glider.be>
 <1487347836-14427-4-git-send-email-geert+renesas@glider.be>
Message-ID: <d66793eb-dc03-e5ba-76e4-904acf6a5de9@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/17/2017 10:10 AM, Geert Uytterhoeven wrote:
> As SoCFPGA uses the standard suspend_valid_only_mem() for its
> platform_suspend_ops.valid() callback, its platform_suspend_ops.enter()
> callback will never be called with state equal to PM_SUSPEND_STANDBY.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/mach-socfpga/pm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-socfpga/pm.c b/arch/arm/mach-socfpga/pm.c
> index c378ab0c24317ccf..d4866788702cb87a 100644
> --- a/arch/arm/mach-socfpga/pm.c
> +++ b/arch/arm/mach-socfpga/pm.c
> @@ -116,7 +116,6 @@ static int socfpga_pm_suspend(unsigned long arg)
>  static int socfpga_pm_enter(suspend_state_t state)
>  {
>  	switch (state) {
> -	case PM_SUSPEND_STANDBY:
>  	case PM_SUSPEND_MEM:
>  		outer_disable();
>  		cpu_suspend(0, socfpga_pm_suspend);
>

Acked-by: Dinh Nguyen <dinguyen@kernel.org>

Dinh
