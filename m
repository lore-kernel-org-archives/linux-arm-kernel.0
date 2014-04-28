From: lznuaa@gmail.com (Frank Li)
Date: Mon, 28 Apr 2014 13:36:44 -0500
Subject: [PATCH 071/222] net:fec: remove unnecessary ip stack includes
In-Reply-To: <E1WdeR9-0007Ht-Tb@rmk-PC.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
 <E1WdeR9-0007Ht-Tb@rmk-PC.arm.linux.org.uk>
Message-ID: <CAHrpEqQ_7iWC_mSRPu7b8JmpBQw+NWO2AkMgBawKmhs9fTvZkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 6:36 AM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Commit 4c09eed9dc42 (net: fec: Enable imx6 enet checksum acceleration.)
> added support for hardware checksum support, adding six new includes
> for things like tcp, udp, ip, icmp, but never made use of anything
> provided by those header files.  Let's remove this bloat.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Russell

       I see patches from 71 to 126 are related with fec driver.
       But maintainer David S. Miller is not in to list.

       Do you need someone follow up this patches and resent to David
S Miller till accepted by david? Or you will do it by yourself?

Best regards
Frank Li

> ---
>  drivers/net/ethernet/freescale/fec_main.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 8d69e439f0c5..b151eaf3b500 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -33,12 +33,6 @@
>  #include <linux/netdevice.h>
>  #include <linux/etherdevice.h>
>  #include <linux/skbuff.h>
> -#include <linux/in.h>
> -#include <linux/ip.h>
> -#include <net/ip.h>
> -#include <linux/tcp.h>
> -#include <linux/udp.h>
> -#include <linux/icmp.h>
>  #include <linux/spinlock.h>
>  #include <linux/workqueue.h>
>  #include <linux/bitops.h>
> --
> 1.8.3.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
