From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Thu, 11 Apr 2013 12:46:57 -0700
Subject: [PATCH] net: mv643xx_eth: remove deprecated inet_lro support
In-Reply-To: <1365707488-28819-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1365707488-28819-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1365709617.3887.185.camel@edumazet-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-04-11 at 21:11 +0200, Sebastian Hesselbarth wrote:
> With recent support for GRO, there is no need to keep both LRO and
> GRO. This patch therefore removes the deprecated inet_lro support
> from mv643xx_eth. This is work is based on an experimental patch
> provided by Eric Dumazet and Willy Tarreau.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Based-on-patch-by: Eric Dumazet <eric.dumazet@gmail.com>
> Based-on-patch-by: Willy Tarreau <w@1wt.eu>
> ---
> Note: This patch is based upon recent cleanup patches and GRO support
> patch for mv643xx_eth.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Lennert Buytenhek <buytenh@wantstofly.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Florian Fainelli <florian@openwrt.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Dale Farnsworth <dale@farnsworth.org>
> Cc: Ben Hutchings <bhutchings@solarflare.com>
> Cc: Soeren Moch <smoch@web.de>
> Cc: Eric Dumazet <eric.dumazet@gmail.com>
> Cc: Willy Tarreau <w@1wt.eu>
> Cc: netdev at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linuxppc-dev at lists.ozlabs.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/net/ethernet/marvell/mv643xx_eth.c |   97 +---------------------------
>  1 file changed, 3 insertions(+), 94 deletions(-)

Seems fine to me, but you also could remove "select INET_LRO"
from drivers/net/ethernet/marvell/Kconfig
