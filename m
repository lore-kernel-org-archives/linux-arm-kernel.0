From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Tue, 27 May 2014 16:56:51 +0300
Subject: [PATCH 1/1] ARM: keystone: Staticize keystone_restart
In-Reply-To: <1401189824-19814-1-git-send-email-sachin.kamat@linaro.org>
References: <1401189824-19814-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <538499A3.7090602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 05/27/2014 02:23 PM, Sachin Kamat wrote:
> 'keystone_restart' is used only in this file.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>   arch/arm/mach-keystone/keystone.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
> index 59b8383cbdb0..4ac124b7e4e8 100644
> --- a/arch/arm/mach-keystone/keystone.c
> +++ b/arch/arm/mach-keystone/keystone.c
> @@ -123,7 +123,7 @@ static const char *keystone_match[] __initconst = {
>   	NULL,
>   };
>   
> -void keystone_restart(enum reboot_mode mode, const char *cmd)
> +static void keystone_restart(enum reboot_mode mode, const char *cmd)
>   {
>   	u32 val;
>   

Hi Sachin,

The function keystone_restart() has been deleted in the following series:
[Patch v7 0/7] Introduce keystone reset driver
https://lkml.org/lkml/2014/5/23/588

So, there is no reason to correct it.

-- 
Regards,
Ivan Khoronzhuk
