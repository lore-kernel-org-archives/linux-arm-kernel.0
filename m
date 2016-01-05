From: davem@davemloft.net (David Miller)
Date: Tue, 05 Jan 2016 16:43:20 -0500 (EST)
Subject: [PATCH] net: hns: avoid uninitialized variable warning:
In-Reply-To: <6649249.INrAY8KJG0@wuerfel>
References: <6649249.INrAY8KJG0@wuerfel>
Message-ID: <20160105.164320.2255971055498857833.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 01 Jan 2016 23:27:57 +0100

> gcc fails to see that the use of the 'last_offset' variable
> in hns_nic_reuse_page() is used correctly and issues a bogus
> warning:
> 
> drivers/net/ethernet/hisilicon/hns/hns_enet.c: In function 'hns_nic_reuse_page':
> drivers/net/ethernet/hisilicon/hns/hns_enet.c:541:6: warning: 'last_offset' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> This simplifies the function to make it more obvious what is
> going on to both readers and compilers, which makes the warning
> go away.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Compile-tested only, and complex enough that this requires a proper
> review and testing before it gets apply. Please have a look at this.

If this goes yet another day without being reviewed, I'm just applying
it.

You hisilicon folks can't just let patches rot, you must review them
in a timely manner or else I'm applying them without waiting for you
to look at them.
