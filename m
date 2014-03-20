From: b32955@freescale.com (Huang Shijie)
Date: Thu, 20 Mar 2014 17:47:57 +0800
Subject: [PATCH] mtd: gpmi: make blockmark swapping optional
In-Reply-To: <20140320102153.7106f915@ipc1.ka-ro>
References: <1395235406-13449-1-git-send-email-y>	<532AB1A2.9010702@freescale.com>
 <20140320102153.7106f915@ipc1.ka-ro>
Message-ID: <532AB94D.1050406@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2014?03?20? 17:21, Lothar Wa?mann ??:
> Hi,
>
> Huang Shijie wrote:
>> ? 2014?03?19? 21:23, y at karo-electronics.de ??:
>>> configurable via DT. This is required for the Ka-Ro electronics
>>> platforms.
>>>
>> If you disable the swapping, you will disable the NAND boot in actually.
>>
> No. All our modules do boot from NAND and none of them does the
> swapping.
>
>
It seems the NAND boot runs well by luck.

The ROM will do the swapping when it reads the BBT table written by the 
kobs-ng (or something else?).

If the BBT table is small, not bigger then a page, the NAND boot may 
runs well when you disable the swapping;
But it the BBT table is bigger, the ROM will get a corrupted BBT table.



thanks
Huang Shijie
