From: davem@davemloft.net (David Miller)
Date: Sat, 25 Nov 2017 23:54:54 +0900 (KST)
Subject: [PATCH net v3] net: thunderx: Fix TCP/UDP checksum offload for
 IPv6 pkts
In-Reply-To: <20171123193432.6925-1-aleksey.makarov@auriga.com>
References: <20171123193014.6632-1-aleksey.makarov@auriga.com>
 <20171123193432.6925-1-aleksey.makarov@auriga.com>
Message-ID: <20171125.235454.1853975778488578912.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Aleksey Makarov <aleksey.makarov@auriga.com>
Date: Thu, 23 Nov 2017 22:34:31 +0300

> From: Sunil Goutham <sgoutham@cavium.com>
> 
> Don't offload IP header checksum to NIC.
> 
> This fixes a previous patch which enabled checksum offloading
> for both IPv4 and IPv6 packets.  So L3 checksum offload was
> getting enabled for IPv6 pkts.  And HW is dropping these pkts
> as it assumes the pkt is IPv4 when IP csum offload is set
> in the SQ descriptor.
> 
> Fixes:  3a9024f52c2e ("net: thunderx: Enable TSO and checksum offloads for ipv6")
> Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Applied.
