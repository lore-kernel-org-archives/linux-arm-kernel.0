From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 6 Jun 2016 11:33:50 -0700
Subject: [PATCH v4 1/7] mdio: mux: Enhanced MDIO mux framework for
 integrated multiplexers
In-Reply-To: <1465216900-11755-2-git-send-email-pramod.kumar@broadcom.com>
References: <1465216900-11755-1-git-send-email-pramod.kumar@broadcom.com>
 <1465216900-11755-2-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <5755C20E.5040308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2016 05:41 AM, Pramod Kumar wrote:
> An integrated multiplexer uses same address space for
> "muxed bus selection" and "generation of mdio transaction"
> hence its good to register parent bus from mux driver.
> 
> Hence added a mechanism where mux driver could register a
> parent bus and pass it down to framework via mdio_mux_init api.
> 
> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>


> diff --git a/include/linux/mdio-mux.h b/include/linux/mdio-mux.h
> index a243dbb..61f5b21 100644
> --- a/include/linux/mdio-mux.h
> +++ b/include/linux/mdio-mux.h
> @@ -10,11 +10,13 @@
>  #ifndef __LINUX_MDIO_MUX_H
>  #define __LINUX_MDIO_MUX_H
>  #include <linux/device.h>
> +#include <linux/phy.h>

You could have added just a forward declaration, this is a pointer to
the structure so you don't need the compiler to have full knowledge of
the storage type. Not a biggie.
-- 
Florian
