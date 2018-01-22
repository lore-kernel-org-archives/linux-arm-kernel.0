From: davem@davemloft.net (David Miller)
Date: Mon, 22 Jan 2018 16:12:37 -0500 (EST)
Subject: [PATCH net-next v2] net: stmmac: Fix reception of Broadcom
 switches tags
In-Reply-To: <20180118231222.19394-1-f.fainelli@gmail.com>
References: <20180118231222.19394-1-f.fainelli@gmail.com>
Message-ID: <20180122.161237.1482527198791478004.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 18 Jan 2018 15:12:21 -0800

> Broadcom tags inserted by Broadcom switches put a 4 byte header after
> the MAC SA and before the EtherType, which may look like some sort of 0
> length LLC/SNAP packet (tcpdump and wireshark do think that way). With
> ACS enabled in stmmac the packets were truncated to 8 bytes on
> reception, whereas clearing this bit allowed normal reception to occur.
> 
> In order to make that possible, we need to pass a net_device argument to
> the different core_init() functions and we are dependent on the Broadcom
> tagger padding packets correctly (which it now does). To be as little
> invasive as possible, this is only done for gmac1000 when the network
> device is DSA-enabled (netdev_uses_dsa() returns true).
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes in v2:
> 
> - fixed build failure in dwmac4_core.c
> - updated dwmac100_core.c to also clear the ASTP bit

Applied, thanks Florian.
