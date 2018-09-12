From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 12 Sep 2018 09:02:29 -0700
Subject: [PATCH] WATCHDOG: uniphier_wdt.c: Fixed error do not initialise
 statics to 0
In-Reply-To: <20180912153354.4658-1-t.jag587@gmail.com>
References: <20180912153354.4658-1-t.jag587@gmail.com>
Message-ID: <20180912160229.GA3300@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2018 at 08:33:54AM -0700, Jagdish Tirumala wrote:
> Fixed error do not initialise statics to 0
> in file drivers/watchdog/uniphier_wdt.c
> 

I don't mind the patch, but I do mind both subject and description
as misleading. This is not an error, except for checkpatch.

A subject such as "watchdog: uniphier_wdt: Do not initialize static
variables to 0" and a description along the line of

Fix the following checkpatch error:

ERROR: do not initialise statics to 0
#44: FILE: drivers/watchdog/uniphier_wdt.c:44:
+static unsigned int timeout = 0;

would be more appropriate.

Please also note that the watchdog subsystem does not use capital
letters to describe the subsystem name, and the driver tag should not
include ".c". As a general note, I would suggest to do a quick browse
through commits in a subsystem to get an idea about its conventions.

Thanks,
Guenter

> Signed-off-by: Jagdish Tirumala <t.jag587@gmail.com>
> ---
>  drivers/watchdog/uniphier_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/uniphier_wdt.c b/drivers/watchdog/uniphier_wdt.c
> index e20a7a459d69..2c62ad7250fb 100644
> --- a/drivers/watchdog/uniphier_wdt.c
> +++ b/drivers/watchdog/uniphier_wdt.c
> @@ -41,7 +41,7 @@
>  #define WDT_PERIOD_MIN			1
>  #define WDT_PERIOD_MAX			128
>  
> -static unsigned int timeout = 0;
> +static unsigned int timeout;
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  
>  struct uniphier_wdt_dev {
> -- 
> 2.17.1
> 
