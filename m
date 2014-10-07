From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 08 Oct 2014 01:41:56 +0200
Subject: [PATCH 03/44] hibernate: Call have_kernel_poweroff instead of
 checking pm_power_off
In-Reply-To: <1412659726-29957-4-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-4-git-send-email-linux@roeck-us.net>
Message-ID: <1798000.odl6y9uKis@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, October 06, 2014 10:28:05 PM Guenter Roeck wrote:
> Poweroff handlers may now be installed with register_poweroff_handler.
> Use the new API function have_kernel_poweroff to determine if a poweroff
> handler has been installed.
> 
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

ACK

> ---
>  kernel/power/hibernate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index a9dfa79..20353c5 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -602,7 +602,7 @@ static void power_down(void)
>  	case HIBERNATION_PLATFORM:
>  		hibernation_platform_enter();
>  	case HIBERNATION_SHUTDOWN:
> -		if (pm_power_off)
> +		if (have_kernel_poweroff())
>  			kernel_power_off();
>  		break;
>  #ifdef CONFIG_SUSPEND
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
