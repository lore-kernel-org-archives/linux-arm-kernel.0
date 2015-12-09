From: davem@davemloft.net (David Miller)
Date: Tue, 08 Dec 2015 22:52:23 -0500 (EST)
Subject: [PATCH] net: fsl: avoid 64-bit warning on pq_mdio
In-Reply-To: <2847304.4thPqtFFJS@wuerfel>
References: <2847304.4thPqtFFJS@wuerfel>
Message-ID: <20151208.225223.1912207413262330164.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 08 Dec 2015 16:17:29 +0100

> The pq_mdio driver can now be built for ARM64, where we get a format
> string warning:
> 
> drivers/net/ethernet/freescale/fsl_pq_mdio.c: In function 'fsl_pq_mdio_probe':
> drivers/net/ethernet/freescale/fsl_pq_mdio.c:467:25: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'long int' [-Wformat=]
> 
> The argument is an implicit ptrdiff_t from the subtraction of two pointers,
> so we should use the %z format string modifier to make this work on 64-bit
> architectures.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: fe761bcb9046 ("net: fsl: expands dependencies of NET_VENDOR_FREESCALE")

Applied.
