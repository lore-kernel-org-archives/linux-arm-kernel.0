From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 06 Dec 2012 21:16:08 +0300
Subject: [v2 PATCH 6/8] watchdog/at91sam9_wdt: Use module_platform_driver()
In-Reply-To: <1354671267-19277-7-git-send-email-wenyou.yang@atmel.com>
References: <1354671267-19277-1-git-send-email-wenyou.yang@atmel.com>
 <1354671267-19277-7-git-send-email-wenyou.yang@atmel.com>
Message-ID: <50C0E0E8.3020809@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/05/2012 04:34 AM, Wenyou Yang wrote:

> Using module_platform_driver() replaces module_init() and module_exit()
> and makes the code simpler.

> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Cc: wim at iguana.be
> Cc: linux-watchdog at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/watchdog/at91sam9_wdt.c |   14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> index 5afd3fb..a7c0881 100644
> --- a/drivers/watchdog/at91sam9_wdt.c
> +++ b/drivers/watchdog/at91sam9_wdt.c
> @@ -278,6 +278,7 @@ MODULE_DEVICE_TABLE(of, at91_wdt_dt_ids);
>  #endif
>  
>  static struct platform_driver at91wdt_driver = {
> +	.probe		= at91wdt_probe,

   You also need to remove '__init' annotation from that function since the
driver becomes hot-plug aware now.

WBR, Sergei
