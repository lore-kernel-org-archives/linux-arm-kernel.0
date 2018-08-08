From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 8 Aug 2018 18:58:46 +0200
Subject: [PATCH v1 6/7] net: mvneta: Don't use GRO on Armada 3720
In-Reply-To: <20180808152706.21727-7-marek.behun@nic.cz>
References: <20180808152706.21727-1-marek.behun@nic.cz>
 <20180808152706.21727-7-marek.behun@nic.cz>
Message-ID: <20180808165846.GK7275@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2018 at 05:27:05PM +0200, Marek Beh?n wrote:
> For some reason on Armada 3720 boards (EspressoBin and Turris Mox) the
> networking driver behaves weirdly when using napi_gro_receive.
> 
> For example downloading a big file from a local network (low ping) is
> fast, but when downloading from a remote server (higher ping), the
> download speed is at first high but drops rapidly to almost nothing or
> absolutely nothing.
> 
> This is fixed when using netif_receive_skb instead of napi_gro_receive.

Before doing this, we should really understand what is going on. It is
probably just a driver bug which needs fixing. And GRO should be good
for performance, so we do want to use it, if possible.

    Andrew
