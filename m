From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 17 Sep 2018 17:24:41 +0200
Subject: [PATCH 0/2] add Ethernet driver support for mt2712
In-Reply-To: <1537165763-13112-1-git-send-email-biao.huang@mediatek.com>
References: <1537165763-13112-1-git-send-email-biao.huang@mediatek.com>
Message-ID: <20180917152441.GD5458@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2018 at 02:29:21PM +0800, Biao Huang wrote:

Adding in the STMMAC driver maintainers.

> Ethernet in mt2712 is totally different from that in
> drivers/net/ethernet/mediatek/*, so we add new folder for mt2712 SoC.
> 
> The mt2712 Ethernet IP is from Synopsys, and we notice that there is a
> reference driver in drivers/net/ethernet/synopsys/*. But
> 1. our version is only for 10/100/1000Mbps, not for 2.5/4/5Gbps.
> mt2712 Ethernet design is differnet from that in synopsys folder in many
> aspects, and some key features are not included in mt2712, such as rss
> and split header. At the same time, some features we need have not been
> implenmented in synopsys folder.

In general, we don't have two very similar drivers. We try to have one
driver. If the problem was just missing features in the stmmac driver,
you can add them. I doubt not supporting 2.5/4/5Gbps in your silicon
is an issue, since very few STMMAC devices have this. By split header,
do you mean support for TSO? That seems to be a gmac4 or newer
feature, but the driver supports not having tso support in hardware.

Giuseppe, Alexandre, Jose: Please can you look at the proposed driver
and see how much it really differs from the STMMAC driver. How easy
would it be to extend stmmac it to support the mt2712?

Thanks
	Andrew
