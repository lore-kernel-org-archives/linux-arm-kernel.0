From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 1 May 2017 22:28:46 +0800
Subject: [PATCH v5 00/20] net-next: stmmac: add dwmac-sun8i ethernet driver
In-Reply-To: <20170501140133.GD31281@lunn.ch>
References: <20170501124520.3769-1-clabbe.montjoie@gmail.com>
 <20170501140133.GD31281@lunn.ch>
Message-ID: <CAGb2v67qGqswdz_JcDaD5jTkcvtBuzqqP8KZh=S_5pkp=o6cUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 1, 2017 at 10:01 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Mon, May 01, 2017 at 02:45:00PM +0200, Corentin Labbe wrote:
>> Hello
>>
>> This patch series add the driver for dwmac-sun8i which handle the Ethernet MAC
>> present on Allwinner H3/H5/A83T/A64 SoCs.
>>
>> This driver is the continuation of the sun8i-emac driver.
>> During the development, it appeared that in fact the hardware was a modified
>> version of some dwmac.
>> So the driver is now written as a glue driver for stmmac.
>>
>> It supports 10/100/1000 Mbit/s speed with half/full duplex.
>> It can use an internal PHY (MII 10/100) or an external PHY
>> via RGMII/RMII.
>
> Hi Corentin
>
> Sorry if this has been asked before....
>
> Does the internal PHY have a phy driver? It seems like
> tx-delay-ps/rx-delay-ps are properties of this internal PHY, and so
> should be in the phy driver, if it has one.

Nope. These affect the delay lines for the external PHY interface.
These have existed since the A20, when the GMAC hardware block and
glue layer controls were introduced.

ChenYu
