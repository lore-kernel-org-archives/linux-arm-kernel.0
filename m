From: msalter@redhat.com (Mark Salter)
Date: Fri, 03 Oct 2014 11:17:22 -0400
Subject: [RFC PATCH 07/16] c6x: support poweroff through poweroff
 handler call chain
In-Reply-To: <1412100056-15517-8-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
 <1412100056-15517-8-git-send-email-linux@roeck-us.net>
Message-ID: <1412349442.5410.14.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-09-30 at 11:00 -0700, Guenter Roeck wrote:
> The kernel core now supports a poweroff handler call chain
> to remove power from the system. Call it if pm_power_off
> is set to NULL.
> 
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

Acked-by: Mark Salter <msalter@redhat.com>

>  arch/c6x/kernel/process.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/c6x/kernel/process.c b/arch/c6x/kernel/process.c
> index 57d2ea8..ddf088e 100644
> --- a/arch/c6x/kernel/process.c
> +++ b/arch/c6x/kernel/process.c
> @@ -75,6 +75,8 @@ void machine_power_off(void)
>  {
>  	if (pm_power_off)
>  		pm_power_off();
> +	else
> +		do_kernel_poweroff();
>  	halt_loop();
>  }
>  
