From: davem@davemloft.net (David Miller)
Date: Tue, 16 Feb 2016 15:37:58 -0500 (EST)
Subject: [PATCH] bridge: mdb: avoid uninitialized variable warning
In-Reply-To: <1455116946-2948649-1-git-send-email-arnd@arndb.de>
References: <1455116946-2948649-1-git-send-email-arnd@arndb.de>
Message-ID: <20160216.153758.1508523820142527071.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 10 Feb 2016 16:09:02 +0100

> A recent change to the mdb code confused the compiler to the point
> where it did not realize that the port-group returned from
> br_mdb_add_group() is always valid when the function returns a nonzero
> return value, so we get a spurious warning:
> 
> net/bridge/br_mdb.c: In function 'br_mdb_add':
> net/bridge/br_mdb.c:542:4: error: 'pg' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>     __br_mdb_notify(dev, entry, RTM_NEWMDB, pg);
> 
> Slightly rearranging the code in br_mdb_add_group() makes the problem
> go away, as gcc is clever enough to see that both functions check
> for 'ret != 0'.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 9e8430f8d60d ("bridge: mdb: Passing the port-group pointer to br_mdb module")

Applied, thanks Arnd.
