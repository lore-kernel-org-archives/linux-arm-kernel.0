From: biao.huang@mediatek.com (Biao Huang)
Date: Mon, 17 Sep 2018 14:29:21 +0800
Subject: [PATCH 0/2] add Ethernet driver support for mt2712
Message-ID: <1537165763-13112-1-git-send-email-biao.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ethernet in mt2712 is totally different from that in
drivers/net/ethernet/mediatek/*, so we add new folder for mt2712 SoC.

The mt2712 Ethernet IP is from Synopsys, and we notice that there is a
reference driver in drivers/net/ethernet/synopsys/*. But
1. our version is only for 10/100/1000Mbps, not for 2.5/4/5Gbps.
mt2712 Ethernet design is differnet from that in synopsys folder in many
aspects, and some key features are not included in mt2712, such as rss
and split header. At the same time, some features we need have not been
implenmented in synopsys folder.
2. MediaTek will lauch new products base on this version continously, and
there will be modifications between these products.

so, we'd better maintain MediaTek's Ethernet driver to support synopsys-ip
based products. And we adopt the frameworks in synopsys/* to develop
Ethernet driver in mt2712.
