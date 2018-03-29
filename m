From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 29 Mar 2018 11:56:37 +0200
Subject: [PATCH] staging: mt7621-eth: Fix sparse warning in ethtool.c
In-Reply-To: <20180328211848.11085-1-cmc@babblebit.net>
References: <20180328211848.11085-1-cmc@babblebit.net>
Message-ID: <20180329095637.GA16778@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2018 at 10:18:48PM +0100, Chris Coffey wrote:
> Include the local ethtool.h header file in mtk_eth_soc.h so
> implementation files have centralized access to it.
> 
> This fixes the following sparse warning:
> 
> drivers/staging/mt7621-eth/ethtool.c:213:6: warning: symbol
> 'mtk_set_ethtool_ops' was not declared. Should it be static?
> 
> Signed-off-by: Chris Coffey <cmc@babblebit.net>
> ---
>  drivers/staging/mt7621-eth/mtk_eth_soc.c | 1 -
>  drivers/staging/mt7621-eth/mtk_eth_soc.h | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/mt7621-eth/mtk_eth_soc.c b/drivers/staging/mt7621-eth/mtk_eth_soc.c
> index cbc7339843..0574e71573 100644
> --- a/drivers/staging/mt7621-eth/mtk_eth_soc.c
> +++ b/drivers/staging/mt7621-eth/mtk_eth_soc.c
> @@ -35,7 +35,6 @@
>  
>  #include "mtk_eth_soc.h"
>  #include "mdio.h"
> -#include "ethtool.h"

How about just moving ethtool.h above the mtk_eth_soc.h include?

Putting .h file dependancies in other .h files is generally not a good
idea if at all possible.  Keeping them "clean" is better, and this
driver has a bunch of work to go there, so let's not make it worse :)

thanks,

greg k-h
