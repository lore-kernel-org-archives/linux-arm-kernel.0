From: davem@davemloft.net (David Miller)
Date: Fri, 18 Dec 2015 14:19:48 -0500 (EST)
Subject: [PATCH] ila: add NETFILTER dependency
In-Reply-To: <2011239.T7zzuZGeyk@wuerfel>
References: <2011239.T7zzuZGeyk@wuerfel>
Message-ID: <20151218.141948.2267406136595226362.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Dec 2015 15:37:37 +0100

> The recently added generic ILA translation facility fails to
> build when CONFIG_NETFILTER is disabled:
> 
> net/ipv6/ila/ila_xlat.c:229:20: warning: 'struct nf_hook_state' declared inside parameter list
> net/ipv6/ila/ila_xlat.c:235:27: error: array type has incomplete element type 'struct nf_hook_ops'
>  static struct nf_hook_ops ila_nf_hook_ops[] __read_mostly = {
> 
> This adds an explicit Kconfig dependency to avoid that case.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 7f00feaf1076 ("ila: Add generic ILA translation facility")

Applied, thanks.
