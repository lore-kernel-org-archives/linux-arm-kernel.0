From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Oct 2011 23:46:21 +0100
Subject: [PATCH 2/2 v2] plat-pxa: break out GPIO driver specifics
In-Reply-To: <1317121014-4749-1-git-send-email-linus.walleij@stericsson.com>
References: <1317121014-4749-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20111001224621.GR11710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 12:56:54PM +0200, Linus Walleij wrote:
> diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
> index 98e25d9..32776f3 100644
> --- a/arch/arm/mach-mmp/gplugd.c
> +++ b/arch/arm/mach-mmp/gplugd.c
> @@ -9,11 +9,11 @@
>   */
>  
>  #include <linux/init.h>
> +#include <linux/gpio.h>
>  
>  #include <asm/mach/arch.h>
>  #include <asm/mach-types.h>
>  
> -#include <mach/gpio.h>
>  #include <mach/pxa168.h>
>  #include <mach/mfp-pxa168.h>
>  

Mine looks like:

diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index c070c24..ef738de 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -9,11 +9,11 @@
  */

 #include <linux/init.h>
+#include <linux/gpio.h>

 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>

-#include <mach/gpio.h>
 #include <mach/pxa168.h>
 #include <mach/mfp-pxa168.h>
 #include <mach/mfp-gplugd.h>
