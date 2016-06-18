From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 18 Jun 2016 15:47:13 +0200
Subject: [PATCH V3] clocksource/drivers/rockchip_timer: Convert init
 function to return error
In-Reply-To: <1466254447-2420-1-git-send-email-daniel.lezcano@linaro.org>
References: <2572341.0UcvQ6PvRt@diego>
 <1466254447-2420-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <5185607.7BCdEvMvLD@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 18. Juni 2016, 14:54:07 schrieb Daniel Lezcano:
> The init functions do not return any error. They behave as the following:
> 
>  - panic, thus leading to a kernel crash while another timer may work and
>    make the system boot up correctly
> 
>  or
> 
>  - print an error and let the caller unaware if the state of the system
> 
> Change that by converting the init functions to return an error conforming
> to the CLOCKSOURCE_OF_RET prototype.
> 
> Proper error handling (rollback, errno value) will be changed later case
> by case, thus this change just return back an error or success in the init
> function.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

looks good now :-)
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

on a rk3399-evb
Tested-by: Heiko Stuebner <heiko@sntech.de>


Heiko
