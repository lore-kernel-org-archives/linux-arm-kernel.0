From: flora.fu@mediatek.com (Flora Fu)
Date: Tue, 9 Dec 2014 10:15:37 +0800
Subject: [PATCH v3 1/8] soc: mediatek: Add PMIC wrapper for MT8135 and
 MT6397 SoC
In-Reply-To: <2751641.o51TuZRl88@wuerfel>
References: <1417752479-4749-1-git-send-email-flora.fu@mediatek.com>
 <1417752479-4749-2-git-send-email-flora.fu@mediatek.com>
 <2751641.o51TuZRl88@wuerfel>
Message-ID: <1418091337.5663.9.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Arnd,

On Fri, 2014-12-05 at 11:13 +0100, Arnd Bergmann wrote:
> On Friday 05 December 2014 12:07:52 Flora Fu wrote:
> > Add PMIC wrapper of MT8135 to access MT6397 MFD.
> > 
> > Signed-off-by: Flora Fu <flora.fu@mediatek.com>
> > 
> 
> Please explain what a PMIC wrapper is and why you need one for MT8135.
> I don't understand the purpose of this code at all. Is this just another
> way of accessing the MT6397 when not using i2c or spi like other
> PMIC drivers do?
> 

Yes, MT8135 uses a proprietary hardware to communicate with MT6397. 
The hardware is called PMIC Wrapper or PWRAP.
Since it is not standard i2c or spi protocols, a soc related software
driver is implemented to handle access protocols in AP side.

+-----------------+           +---------------+
|                 |           |               |
| Mediatek AP SoC |           |               |
| (ex. MT8135)    |           |    MT6397     |
|                 |           |               |
|      +--------+ | (SPI bus) | +--------+    |
|      |        | |-----------| |        |    |
|      |  PMIC  | |-----------| |  PMIC  |    |
|      | Wrapper| |-----------| | Wrapper|    |
|      |        | |-----------| |        |    |
|      +--------+ |           | +--------+    |
|                 |           |               |
+-----------------+           +---------------+

Thanks,
Flora
