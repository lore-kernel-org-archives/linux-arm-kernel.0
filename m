From: davem@davemloft.net (David Miller)
Date: Sat, 19 Dec 2015 00:10:58 -0500 (EST)
Subject: [PATCH] netcp: fix regression in receive processing
In-Reply-To: <1651314.QiL8XMyoqS@wuerfel>
References: <1651314.QiL8XMyoqS@wuerfel>
Message-ID: <20151219.001058.862320196789855068.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Dec 2015 15:18:08 +0100

> A cleanup patch I did was unfortunately wrong and introduced
> multiple serious bugs in the netcp rx processing, as indicated
> by these correct gcc warnings:
> 
> drivers/net/ethernet/ti/netcp_core.c:776:14: warning: 'buf_ptr' may be used uninitialized in this function [-Wuninitialized]
> drivers/net/ethernet/ti/netcp_core.c:687:14: warning: 'ptr' may be used uninitialized in this function [-Wuninitialized]
> 
> I have checked the patch once more and found that a call to
> get_pkt_info() accidentally got removed in netcp_free_rx_desc_chain,
> and netcp_process_one_rx_packet no longer retrieved the correct
> buffer length. This patch should fix all the known problems,
> but I did not test on real hardware.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 899077791403 ("netcp: try to reduce type confusion in descriptors")

Applied.
