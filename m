From: davem@davemloft.net (David Miller)
Date: Mon, 09 Apr 2018 11:00:16 -0400 (EDT)
Subject: [PATCH v5] net: thunderx: rework mac addresses list to u64 array
In-Reply-To: <20180409132448.22278-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180406195354.16037-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180409132448.22278-1-Vadim.Lomovtsev@caviumnetworks.com>
Message-ID: <20180409.110016.166919257730352493.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Date: Mon,  9 Apr 2018 06:24:48 -0700

> From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> 
> It is too expensive to pass u64 values via linked list, instead
> allocate array for them by overall number of mac addresses from netdev.
> 
> This eventually removes multiple kmalloc() calls, aviod memory
> fragmentation and allow to put single null check on kmalloc
> return value in order to prevent a potential null pointer dereference.
> 
> Addresses-Coverity-ID: 1467429 ("Dereference null return value")
> Fixes: 37c3347eb247 ("net: thunderx: add ndo_set_rx_mode callback implementation for VF")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

Applied, thanks.
