From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 20 Mar 2014 22:34:57 +0300
Subject: [PATCH 06/62] ARM: davinci: export da8xx_syscfg0_base
In-Reply-To: <5091055.xba9009NTn@wuerfel>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <201403201250.45005.arnd@arndb.de> <532B3A91.6000800@cogentembedded.com>
 <5091055.xba9009NTn@wuerfel>
Message-ID: <532B42E1.6080804@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03/20/2014 09:22 PM, Arnd Bergmann wrote:

>>      Yes, it does. The issue is that the PHY code is different in MUSB and OHCI
>> drivers. I don't think the PHY driver knows what device binds to it.

> At least in the DT case, it can get that information from DT, when you
> set #phy-cells=<1>. I don't know how it would be done for platform_data,
> but I assume one could find a way too.

    #phy-cells is only defined for drivers/phy/ bindings IIRC, and I was 
thinking a drivers/usb/phy/ driver so far. Probably you have a point and we 
should go for the generic PHY framework instead. I'm just not very familiar 
with it...

> 	Arnd

WBR, Sergei
